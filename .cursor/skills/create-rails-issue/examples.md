# Examples

## bug

Title: `Active Record: has_many through association drops the scope when preloaded`

~~~~markdown
### Issue name

Active Record: has_many through association drops the scope when preloaded

### Issue type

bug

### Impact

Apps that preload a scoped has_many :through association get unscoped records. Calling the association without preload returns the scoped set, so callers can avoid preload as a workaround.

### Description

`Preloader` builds the through association but does not apply the scope defined on the has_many. The bug is in Active Record preloading.

### Steps to reproduce

```ruby
# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"
  gem "rails"
end

require "active_record"
require "minitest/autorun"

# ... models, schema, and a test that fails when the association is preloaded
```

### Expected behavior

The preloaded association includes only rows that match the scope.

### Actual behavior

The preloaded association includes rows outside the scope.

### System configuration

**Rails version**: 8.1.0

**Ruby version**: 3.4.1

### Affected component

activerecord
~~~~

## feature

Title: `Active Job: add a wait_until option that accepts a business-calendar proc`

A wishlist with no API sketch does not become an issue. This one has a proposed behavior, so it can be filed when the user asked for a GitHub issue or already has rails-core support. Otherwise post the same body to the forum.

```markdown
### Issue name

Active Job: add a wait_until option that accepts a business-calendar proc

### Issue type

feature

### Impact

Jobs that must run on the next business day reimplement calendar math in every app. There is no framework API for it.

### Description

Add a wait_until form that accepts a callable returning the next time the job may run.

### Motivation

wait_until already accepts a timestamp. Apps with business-day rules cannot express that rule without scheduling a follow-up job themselves.

### Proposed behavior

`SomeJob.set(wait_until: -> { BusinessCalendar.next_open }).perform_later` enqueues the job at the time the callable returns. The callable is invoked once, when `set` is called.

### Alternatives considered

Keep the logic in each app. Rejected because every app rewrites the same enqueue wrapper.

### Affected component

activejob
```

## documentation

Title: `Guides: configuring.md omits remove_hidden_field_autocomplete`

```markdown
### Issue name

Guides: configuring.md omits remove_hidden_field_autocomplete

### Issue type

documentation

### Impact

Readers of the configuration guide cannot tell that Action View can omit autocomplete="off" on hidden fields. They discover the flag only by reading the framework source.

### Description

Document `config.action_view.remove_hidden_field_autocomplete` next to the other Action View settings, including its default before and after load_defaults 8.1.

### Location

guides/source/configuring.md

### What's wrong or missing

The flag exists on ActionView::Base and is set in load_defaults, and the configuring guide does not mention it.

### Suggested change

Add a row for `config.action_view.remove_hidden_field_autocomplete` with the default and a one-line description of when hidden fields get autocomplete="off".
```
