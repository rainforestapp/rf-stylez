# RF Stylez 😎

This is a place for style configurations for [Rainforest QA](https://www.rainforestqa.com/about/) code.

### Releasing

- Make sure your changes are merged into `master` and...
- that `VERSION` in `lib/rf/stylez/version.rb` file is updated
- pull latest master
- run `rake release:source_control_push`
- CI/CD will take care of releasing rf-stylez to rubygems
