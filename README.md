# RF Stylez 😎

This is a place for style configurations for [Rainforest QA](https://www.rainforestqa.com/about/) code.

### Releasing

- Make sure your changes are merged into `master` and...
- that `VERSION` in `lib/rf/stylez/version.rb` file is updated
- pull latest master
- run `rake release:source_control_push`
- CI/CD will take care of releasing rf-stylez to rubygems

## Adding `rf-stylez` to a new project

### For Ruby projects
Create a `.rubocop.yml` in the root project directory and paste the following:
```yml
inherit_gem:
  rf-stylez: ruby/rubocop.yml
```

### For Rails projects
Create a `.rubocop.yml` in the root project directory and paste the following:
```yml
inherit_gem:
  rf-stylez:
    - ruby/rubocop.yml
    - rails/rubocop.yml
```

To use it you'll need to install rf-stylez locally:
```bash
gem install rf-stylez
```

To check if you version is the latest on (for example in a git hook)
```bash
rf-stylez check-latest
```
