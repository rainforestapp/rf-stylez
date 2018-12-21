# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoGrapeAPI do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when inheriting `Grape::API`' do
    expect_offense(<<-RUBY.strip_indent)
      class Foo < Grape::API
      ^^^^^^^^^^^^^^^^^^^^^^ Prefer inheriting `Api::AuthBase` or `Api::Base` instead of `Grape::API`.
        puts('foo')
      end
    RUBY
  end

  it 'does not register an offense when using `Api::AuthBase`' do
    expect_no_offenses(<<-RUBY.strip_indent)
      class Foo < Api::AuthBase
        puts('foo')
      end
    RUBY
  end

  it 'does not register an offense when using `Api::AuthBase`' do
    expect_no_offenses(<<-RUBY.strip_indent)
      class Foo < Api::Base
        puts('foo')
      end
    RUBY
  end

  it 'does not register an offense when using `Grape::API::Helpers`' do
    expect_no_offenses(<<-RUBY.strip_indent)
      module Api::Helpers::Run
        extend Grape::API::Helpers
      end
    RUBY
  end
end
