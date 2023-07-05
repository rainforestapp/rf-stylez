# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoJSON do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it "registers an offense when using `#JSON`" do
    expect_offense(<<~RUBY)
      JSON
      ^^^^ Lint/NoJSON: Use `MultiJson` instead of `JSON`.
    RUBY
  end

  it "does not register an offense when using `#MultiJson`" do
    expect_no_offenses(<<~RUBY)
      MultiJson
    RUBY
  end
end
