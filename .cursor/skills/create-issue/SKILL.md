---
name: create-issue
description: Creates a GitHub issue for this repository from the bug report template, with the title "Issue name". Use when the user asks to create, file, open, or draft an issue for this repo.
---

# Create an issue

File a GitHub issue on the repository of the current checkout. The issue title is the issue name.

## Titles

The issue should have these titles:

- Issue name

Set the GitHub issue title to the issue name. In the body, use that same wording as the first heading:

```markdown
## Issue name

<one-line name of the issue>
```

The text under that heading is the `--title` value. Do not add other title lines.

## Before filing

1. Resolve the repo with `gh repo view --json nameWithOwner -q .nameWithOwner`. File the issue there.
2. If the report is a security vulnerability, do not open an issue. Point to the [Rails security policy](https://rubyonrails.org/security) and stop.
3. If the request is a feature or a wishlist with no bug, do not open an issue. Point to the [rubyonrails-core forum](https://discuss.rubyonrails.org/c/rubyonrails-core) and stop.
4. Search open issues for the same bug:

```bash
gh issue list --repo <owner/repo> --state open --search "<issue name>" --limit 20
```

If an open issue already covers it, link that issue and stop.

## Body

Use `.github/ISSUE_TEMPLATE/bug_report.md`. Fill every section. Paste an executable test case in the reproduction block. Start from the template that matches the component, edit it so the test fails, and confirm it runs:

| Component | Template |
|-----------|----------|
| Active Record | `guides/bug_report_templates/active_record.rb` |
| Active Record migrations | `guides/bug_report_templates/active_record_migrations.rb` |
| Action Pack | `guides/bug_report_templates/action_controller.rb` |
| Action View | `guides/bug_report_templates/action_view.rb` |
| Active Job | `guides/bug_report_templates/active_job.rb` |
| Active Storage | `guides/bug_report_templates/active_storage.rb` |
| Action Mailer | `guides/bug_report_templates/action_mailer.rb` |
| Action Mailbox | `guides/bug_report_templates/action_mailbox.rb` |
| Anything else | `guides/bug_report_templates/generic.rb` |

~~~markdown
## Issue name

<one-line name of the issue>

### Steps to reproduce

```ruby
<failing executable test case>
```

### Expected behavior

<what should happen>

### Actual behavior

<what happens instead>

### System configuration

**Rails version**:

**Ruby version**:
~~~

Leave Rails version and Ruby version blank only when the user did not provide them. Do not invent reproduction code that does not fail.

## Create

Write the body to a temp file, then:

```bash
gh issue create --repo <owner/repo> --title "<issue name>" --body-file <file>
```

Return the issue URL. Do not add labels unless the user names them.
