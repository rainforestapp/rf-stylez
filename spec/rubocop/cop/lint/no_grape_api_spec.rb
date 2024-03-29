# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoGrapeAPI do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it "registers an offense when inheriting `Grape::API`" do
    expect_offense(<<~RUBY)
      class Foo < Grape::API
      ^^^^^^^^^^^^^^^^^^^^^^ Lint/NoGrapeAPI: Prefer inheriting `Api::AuthBase` or `Api::Base` instead of `Grape::API`.
        puts('foo')
      end
    RUBY
  end

  it "does not register an offense when using `Api::AuthBase`" do
    expect_no_offenses(<<~RUBY)
      class Foo < Api::AuthBase
        puts('foo')
      end
    RUBY
  end

  it "does not register an offense when using `Api::Base`" do
    expect_no_offenses(<<~RUBY)
      class Foo < Api::Base
        puts('foo')
      end
    RUBY
  end

  it "does not register an offense when using `Grape::API::Helpers`" do
    expect_no_offenses(<<~RUBY)
      module Api::Helpers::Run
        extend Grape::API::Helpers
      end
    RUBY
  end
end
