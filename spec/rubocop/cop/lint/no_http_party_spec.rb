# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoHTTParty do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it "registers an offense when using `HTTParty`" do
    expect_offense(<<~RUBY)
      HTTParty.get('foo')
      ^^^^^^^^^^^^^^^^^^^ Prefer `TimedRequest` instead of raw `HTTParty` calls.
    RUBY
  end

  it "does not register an offense when using `TimedRequest`" do
    expect_no_offenses(<<~RUBY)
      TimedRequest.get('foo')
    RUBY
  end
end
