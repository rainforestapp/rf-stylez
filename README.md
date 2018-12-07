# RF Stylez 😎

This is a place for style configurations for [Rainforest QA](https://www.rainforestqa.com/about/) code.

### Releasing

- Make sure you're an owner on rubygems.org
- `rake release`


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
