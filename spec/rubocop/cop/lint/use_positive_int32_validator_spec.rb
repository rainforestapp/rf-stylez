# frozen_string_literal: true

describe RuboCop::Cop::Lint::UserPositiveInt32Validator do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  ['requires','optional'].each do |method|
    it "registers an offense when not validating Integers in a Grape API `#{method}`" do
      expect_offense(<<-RUBY.strip_indent)
        #{method} :id, type: Integer, desc: 'Comment ID'
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
      RUBY
    end

    it "registers an offense when not validating Integers in a Grape API `#{method}`" do
      expect_offense(<<-RUBY.strip_indent)
        #{method} :id, desc: 'Comment ID', type: Integer
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
      RUBY
    end

    it "registers an offense when not validating Integers in a Grape API `#{method}`" do
      expect_offense(<<-RUBY.strip_indent)
      params do
        #{method} :id, desc: 'Comment ID', type: Integer
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
        requires :text, type: String
      end
      RUBY
    end

    it "registers an offense when not validating Integers in a Grape API `#{method}`" do
      expect_offense(<<-RUBY.strip_indent)
      params :test do
        #{method} :id, desc: 'Comment ID', type: Integer
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
      end
      RUBY
    end

    it 'does not register an offense when positive_int32 is true' do
      expect_no_offenses(<<-RUBY.strip_indent)
      #{method} :id, type: Integer, positive_int32: true, desc: 'Comment ID'
      RUBY
    end

    it 'does not register an offense when positive_int32 is true' do
      expect_no_offenses(<<-RUBY.strip_indent)
      #{method} :id, type: Integer, desc: 'Comment ID', documentation: { blah: 'blah' }, positive_int32: true
      RUBY
    end
  end
end
