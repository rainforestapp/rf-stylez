# frozen_string_literal: true

describe RuboCop::Cop::Lint::UsePositiveInt32Validator do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it "handles a big params with nested params and such" do
    expect_offense(<<~RUBY)
      params :example_params do
        optional :id, type: Integer
                      ^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
        optional :abc, type: String
        optional :edf, types: [String, Array[String]]
        optional :ghi, type: Hash, documentation: { hidden: true }
        optional :elements, type: Array, coerce_with: abcdefg do
          optional :zyx, type: Boolean
          optional :id, type: Integer
                        ^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          requires :type, type: String, values: ['123', 'abc']
          requires :element, type: Hash do
            optional :id, type: Integer
                          ^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
            optional :action, type: String
            all_or_none_of :action, :response
          end
        end
        optional :variables, type: Array[Entities::Foobar]
      end
    RUBY
  end

  %w(requires optional).each do |method|
    context "registers an offense when not validating Integers in a Grape API `#{method}`" do
      specify do
        expect_offense(<<~RUBY)
          params do
            #{method} :id, type: Integer, desc: 'Comment ID'
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          end
        RUBY
      end

      it "handles different parameter orders" do
        expect_offense(<<~RUBY)
          params do
            #{method} :id, desc: 'Comment ID', type: Integer
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          end
        RUBY
      end

      it "handles multiple arguments" do
        expect_offense(<<~RUBY)
          params do
            #{method} :id, type: Integer, desc: 'Comment ID'
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
            requires :text, type: String
          end
        RUBY
      end

      it "handles multiple arguments, in mixed order" do
        expect_offense(<<~RUBY)
          params do
            requires :text, type: String
            #{method} :id, type: Integer, desc: 'Comment ID'
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
            requires :text, type: String
            requires :id2, type: Integer, desc: 'Comment ID'
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          end
        RUBY
      end

      it "handles named params blocks" do
        expect_offense(<<~RUBY)
          params :test do
            #{method} :id, type: Integer, desc: 'Comment ID'
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Lint/UsePositiveInt32Validator: If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          end
        RUBY
      end
    end

    it "does not register an offense when not in a params block" do
      expect_no_offenses(<<~RUBY)
        #{method} :id, type: Integer, desc: 'Comment ID'
      RUBY
    end

    context "does not register an offense when positive_int32 is true" do
      specify do
        expect_no_offenses(<<~RUBY)
          params :test do
            #{method} :id, type: Integer, desc: 'Comment ID', positive_int32: true
          end
        RUBY
      end

      it "handles a bunch of arguments" do
        expect_no_offenses(<<~RUBY)
          params :test do
            #{method} :id, type: Integer, desc: 'Comment ID', documentation: { blah: 'blah' }, positive_int32: true
          end
        RUBY
      end
    end

    context "does not register an offense when positive_int32 is false" do
      specify do
        expect_no_offenses(<<~RUBY)
          params :test do
            #{method} :id, type: Integer, desc: 'Comment ID', positive_int32: false
          end
        RUBY
      end
    end

    context "does not register an offense when positive_int32 takes in a value" do
      specify do
        expect_no_offenses(<<~RUBY)
          params :test do
            #{method} :id, type: Integer, desc: 'Comment ID', positive_int32: -1
          end
        RUBY
      end
    end
  end
end
