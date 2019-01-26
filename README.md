# RF Stylez 😎

This is a place for style configurations for [Rainforest QA](https://www.rainforestqa.com/about/) code.

### Releasing

- Make sure your changes are merged into `master` and...
- that `VERSION` in `lib/rf/stylez/version.rb` file is updated
- pull latest master
- run `rake release:source_control_push`
- CI/CD will take care of releasing rf-stylez to rubygems
- Update circlemator `bundle update rf-stylez`

## Adding `rf-stylez` to a new project

Create a `.rubocop.yml` in the root project directory and paste the following:
```yml
inherit_gem:
  rf-stylez: ruby/rubocop.yml
Style/HashSyntax:
  Enabled: true
```

To use it install rubocop and rf-stylez locally:
```bash
gem install rf-stylez
```
