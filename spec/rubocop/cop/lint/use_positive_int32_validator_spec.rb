# frozen_string_literal: true

describe RuboCop::Cop::Lint::UserPositiveInt32Validator do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when not validating Integers in a Grape API `requires`' do
    expect_offense(<<-RUBY.strip_indent)
      requires :id, type: Integer, desc: 'Comment ID'
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
    RUBY
  end

  it 'registers an offense when not validating Integers in a Grape API `requires`' do
    expect_offense(<<-RUBY.strip_indent)
      requires :id, desc: 'Comment ID', type: Integer
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
    RUBY
  end

  it 'does not register an offense when already validating' do
    expect_no_offenses(<<-RUBY.strip_indent)
    requires :id, type: Integer, desc: 'Comment ID', positive_int32: true
    RUBY
  end

  it 'does not register an offense when already validating' do
    expect_no_offenses(<<-RUBY.strip_indent)
    requires :id, type: Integer, positive_int32: true
    RUBY
  end

  it 'does not register an offense when already validating' do
    expect_no_offenses(<<-RUBY.strip_indent)
    requires :id, type: Integer, positive_int32: true, desc: 'Comment ID'
    RUBY
  end

  it 'does not register an offense when already validating' do
    expect_no_offenses(<<-RUBY.strip_indent)
    requires :id, type: Integer, desc: 'Comment ID', documentation: { blah: 'blah' }, positive_int32: true
    RUBY
  end
end
