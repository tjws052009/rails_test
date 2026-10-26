#!/usr/bin/env ruby
# frozen_string_literal: true

# Check an issue body before `gh issue create`.
# Usage: ruby .cursor/skills/create-rails-issue/scripts/validate_issue.rb path/to/issue.md
# Prints "OK", or lists problems on stderr and exits 1.

REQUIRED = [
  "Issue name",
  "Issue type",
  "Impact",
  "Description"
].freeze

EXTRA = {
  "bug" => [
    "Steps to reproduce",
    "Expected behavior",
    "Actual behavior",
    "System configuration",
    "Affected component"
  ],
  "regression" => [
    "Steps to reproduce",
    "Expected behavior",
    "Actual behavior",
    "Last known good version",
    "System configuration",
    "Affected component"
  ],
  "enhancement" => [
    "Current behavior",
    "Proposed change",
    "Alternatives considered",
    "Affected component"
  ],
  "feature" => [
    "Motivation",
    "Proposed behavior",
    "Alternatives considered",
    "Affected component"
  ],
  "documentation" => [
    "Location",
    "What's wrong or missing",
    "Suggested change"
  ]
}.freeze

HEADING = /^\#{1,6}\s+(.+?)\s*$/.freeze
COMPONENTS = %w[
  actioncable actionmailbox actionmailer actionpack actiontext actionview
  activejob activemodel activerecord activestorage activesupport railties guides
].freeze

def sections(text)
  current = nil
  body = {}
  order = []
  in_fence = false
  fence_char = nil

  text.each_line do |line|
    if in_fence
      in_fence = false if line.start_with?(fence_char * 3)
    elsif line.match?(/\A(?:`{3,}|~{3,})/)
      in_fence = true
      fence_char = line[0]
    elsif (match = HEADING.match(line))
      current = match[1].strip
      unless body.key?(current)
        order << current
        body[current] = +""
      end
      next
    end

    body[current] << line if current
  end

  [order, body]
end

def meaningful(text)
  text.to_s.gsub(/<!--.*?-->/m, "").strip
end

path = ARGV[0]
unless path && File.file?(path)
  warn "usage: validate_issue.rb ISSUE.md"
  exit 1
end

order, body = sections(File.read(path))
errors = []

if order.first(REQUIRED.length) != REQUIRED
  missing = REQUIRED.reject { |heading| order.include?(heading) }
  if missing.any?
    errors << "missing required headings: #{missing.join(', ')}"
  else
    errors << "the first four headings must be, in order: #{REQUIRED.join(', ')}"
  end
end

type_line = meaningful(body["Issue type"]).lines.map(&:strip).reject(&:empty?).first.to_s
type = type_line.downcase
errors << "Issue type is empty" if type.empty?
errors << "Issue type must be a single word" if type.match?(/\s/)

known_extra = EXTRA[type]
if known_extra
  extra_missing = known_extra.reject { |heading| order.include?(heading) }
  errors << "missing #{type} headings: #{extra_missing.join(', ')}" if extra_missing.any?
elsif type != "" && !order.include?("Affected component")
  errors << "missing Affected component for issue type #{type}"
end

check_headings = REQUIRED + (known_extra || ["Affected component"])
check_headings.each do |heading|
  next unless order.include?(heading)

  content = meaningful(body[heading])
  errors << "#{heading} is empty" if content.empty?
  errors << "#{heading} still contains [REPLACE ME]" if content.include?("[REPLACE ME]")
end

name = meaningful(body["Issue name"])
errors << "Issue name must be a single line" if name.lines.count > 1

if %w[bug regression].include?(type) && order.include?("Steps to reproduce")
  code = body["Steps to reproduce"].to_s.scan(/```[^\n]*\n(.*?)```/m).flatten
  executable = code.any? do |block|
    block.lines.any? { |line| line.strip != "" && !line.strip.start_with?("#") }
  end
  errors << "Steps to reproduce must include a fenced executable test case" unless executable
end

if order.include?("Affected component")
  component = meaningful(body["Affected component"]).lines.map(&:strip).reject(&:empty?).first.to_s.downcase
  unless COMPONENTS.include?(component)
    errors << "Affected component must be one of: #{COMPONENTS.join(', ')}"
  end
end

if errors.empty?
  puts "OK"
  exit 0
end

warn "issue body is incomplete:"
errors.each { |error| warn "- #{error}" }
exit 1
