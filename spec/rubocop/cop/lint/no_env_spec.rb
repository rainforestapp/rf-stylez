# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoENV do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using `#ENV`' do
    expect_offense(<<-RUBY.strip_indent)
      ENV
      ^^^ Use `GetEnv` instead of `ENV`.
    RUBY
  end

  it 'does not register an offense when using `#GetEnv`' do
    expect_no_offenses(<<-RUBY.strip_indent)
      GetEnv
    RUBY
  end
end
