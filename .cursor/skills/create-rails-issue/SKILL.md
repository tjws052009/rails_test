---
name: create-rails-issue
description: Draft and open GitHub issues for this Ruby on Rails repository with a body that always includes Issue name, Issue type, Impact, and Description, then adds headings that change by issue type (bug, regression, enhancement, feature, documentation). Use when the user asks to create, file, open, or draft a GitHub issue, bug report, regression, enhancement, feature request, or documentation issue.
---

# Create a Rails issue

File issues on the repository of the current checkout (`gh` default repo). Read [templates.md](templates.md) for the body to fill. Read [examples.md](examples.md) when the wording of a section is unclear.

## Required headings

Every issue body starts with these headings, in this order, spelled exactly this way. Add the type-specific headings after them. Do not rename, drop, or reorder the four.

1. Issue name
2. Issue type
3. Impact
4. Description

`Issue name` is one line and is also the GitHub issue title. `Issue type` is a single word from the table below (or a more specific word when none fit).

## Issue types

| Issue type | Use when | Label | Extra headings |
|---|---|---|---|
| `bug` | Existing behavior is incorrect | `bug` | Steps to reproduce, Expected behavior, Actual behavior, System configuration, Affected component |
| `regression` | Behavior used to be correct and broke in a later version | `bug` | Same as `bug`, plus Last known good version |
| `enhancement` | Existing behavior should improve, and it is not incorrect | `enhancement` | Current behavior, Proposed change, Alternatives considered, Affected component |
| `feature` | The change adds new behavior | `enhancement` | Motivation, Proposed behavior, Alternatives considered, Affected component |
| `documentation` | Guides, API docs, or comments are wrong or missing | `documentation` | Location, What's wrong or missing, Suggested change |

If the request fits none of these, set `Issue type` to a single specific word (for example `performance`) and use only the four required headings plus `Affected component`.

Add the `accessibility` label as well when the issue is a barrier for people with disabilities.

`Affected component` is one of: `actioncable`, `actionmailbox`, `actionmailer`, `actionpack`, `actiontext`, `actionview`, `activejob`, `activemodel`, `activerecord`, `activestorage`, `activesupport`, `railties`, `guides`.

## Do not open an issue

- **Security.** Do not create a public GitHub issue. Direct the report to [the Rails security policy](https://rubyonrails.org/security).
- **Usage question.** Send it to [rubyonrails-talk](https://discuss.rubyonrails.org/c/rubyonrails-talk). Do not open an issue.
- **Feature or enhancement with no concrete proposal.** A wishlist with no behavior, API shape, or patch plan is closed as invalid. Do not run `gh issue create`. Return the filled template and tell the user to post it on [rubyonrails-core](https://discuss.rubyonrails.org/c/rubyonrails-core).
- **Duplicate.** If an open issue already covers it, return that URL and stop.

Open a `feature` or `enhancement` issue only when the user explicitly asked to file it on GitHub, or they already have positive rails-core feedback or a patch. Say in the reply that a wishlist without code is closed as invalid.

## Workflow

1. Classify the issue type. Ask for a missing required fact (what breaks, who is affected, reproduction). Do not invent Rails or Ruby versions, stack traces, or reproduction steps.
2. Search duplicates in this repo:

```bash
gh issue list --state open --limit 20 --search "keywords from the issue name"
gh issue list --state closed --limit 10 --search "keywords from the issue name"
```

3. Copy the matching skeleton from [templates.md](templates.md). Fill every heading. Strip the HTML guidance comments before filing.
4. For `bug` and `regression`, build the executable test case from the template for that component and paste it under Steps to reproduce:

| Component | Template |
|---|---|
| `activerecord` | `guides/bug_report_templates/active_record.rb` |
| `activerecord` migrations | `guides/bug_report_templates/active_record_migrations.rb` |
| `actionpack` | `guides/bug_report_templates/action_controller.rb` |
| `actionview` | `guides/bug_report_templates/action_view.rb` |
| `activejob` | `guides/bug_report_templates/active_job.rb` |
| `activestorage` | `guides/bug_report_templates/active_storage.rb` |
| `actionmailer` | `guides/bug_report_templates/action_mailer.rb` |
| `actionmailbox` | `guides/bug_report_templates/action_mailbox.rb` |
| anything else | `guides/bug_report_templates/generic.rb` |

5. Write the body to a temp file and validate it. Fix every reported line and run it again. File only after it prints `OK`.

```bash
ruby .cursor/skills/create-rails-issue/scripts/validate_issue.rb /tmp/rails-issue.md
```

6. Create the issue only when the user asked to file or open it. A draft request stops after the validated body.

```bash
gh issue create --title "<Issue name line>" --body-file /tmp/rails-issue.md --label "<label>"
```

Pass `--label accessibility` in addition when it applies. Do not pass labels that `gh label list` does not show.

7. Reply with the issue URL, the issue type, and any duplicate you considered.

## Section rules

- **Issue name.** Specific symptom or change. Lead with the component when it is known: `Active Record: preload ignores ...`.
- **Impact.** Who is affected, what breaks or improves, whether a workaround exists.
- **Description.** What happens or what should change, in plain language. Name the framework area. Do not repeat Impact verbatim.
- **Alternatives considered.** Write `None.` when there are none. Do not leave the heading empty.
- Leave Rails version and Ruby version blank only when the user does not know them. Never invent them.
