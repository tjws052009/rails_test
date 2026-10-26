# Issue body skeletons

Copy one skeleton. Keep the headings. Delete the HTML comments before `gh issue create`.

`Issue name` matches the GitHub title. `Issue type` is exactly one of `bug`, `regression`, `enhancement`, `feature`, `documentation`, or a single more specific word.

## bug

~~~~markdown
### Issue name

### Issue type

bug

### Impact

<!-- Who is affected, what breaks, and whether a workaround exists. -->

### Description

<!-- What is incorrect, and in which framework area. -->

### Steps to reproduce

<!-- Paste an executable test case from guides/bug_report_templates/. -->

```ruby
# executable test case
```

### Expected behavior

### Actual behavior

### System configuration

**Rails version**:

**Ruby version**:

### Affected component

<!-- One of actioncable, actionmailbox, actionmailer, actionpack, actiontext, actionview, activejob, activemodel, activerecord, activestorage, activesupport, railties, guides. -->
~~~~

## regression

~~~~markdown
### Issue name

### Issue type

regression

### Impact

<!-- Who is affected, what broke, and whether a workaround exists. -->

### Description

<!-- What changed, and in which framework area. -->

### Steps to reproduce

```ruby
# executable test case
```

### Expected behavior

### Actual behavior

### Last known good version

<!-- Rails version that still behaved correctly, or "unknown". -->

### System configuration

**Rails version**:

**Ruby version**:

### Affected component
~~~~

## enhancement

~~~~markdown
### Issue name

### Issue type

enhancement

### Impact

<!-- Who benefits, and how the current behavior falls short. -->

### Description

<!-- What existing behavior should improve. -->

### Current behavior

### Proposed change

### Alternatives considered

<!-- Write "None." if there are none. -->

### Affected component
~~~~

## feature

~~~~markdown
### Issue name

### Issue type

feature

### Impact

<!-- Who benefits, and what they cannot do today. -->

### Description

<!-- The new behavior in plain language. -->

### Motivation

<!-- Why this belongs in Rails. Link a rails-core thread when one exists. -->

### Proposed behavior

<!-- Concrete behavior or API shape. -->

### Alternatives considered

<!-- Write "None." if there are none. -->

### Affected component
~~~~

## documentation

~~~~markdown
### Issue name

### Issue type

documentation

### Impact

<!-- Who is misled, and what they do wrong because of it. -->

### Description

<!-- What the docs should say instead. -->

### Location

<!-- Guide path, API page, or file. -->

### What's wrong or missing

### Suggested change
~~~~

## other

Use this when the issue type is a single word that is not listed above. Put that word under Issue type.

~~~~markdown
### Issue name

### Issue type

### Impact

### Description

### Affected component
~~~~
