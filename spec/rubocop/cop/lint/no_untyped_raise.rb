# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoUntypedRaise do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  describe "untyped" do
    context "raise" do
      it "registers an offense" do
        expect_offense(<<~RUBY)
          def foo
            raise 'foo'
            ^^^^^^^^^^^ Do not raise untyped exceptions, specify the error type so it can be rescued specifically.
          end
        RUBY
      end
    end

    context "fail" do
      it "registers an offense" do
        expect_offense(<<~RUBY)
          def foo
            fail 'foo'
            ^^^^^^^^^^ Do not raise untyped exceptions, specify the error type so it can be rescued specifically.
          end
        RUBY
      end
    end
  end

  describe "typed" do
    context "raise" do
      it "registers no offense" do
        expect_no_offenses(<<~RUBY)
        def foo
          raise ArgumentError, 'foo'
        end
        RUBY
      end
    end

    context "fail" do
      it "registers no offense" do
        expect_no_offenses(<<~RUBY)
        def foo
          fail ArgumentError, 'foo'
        end
        RUBY
      end
    end
  end
end
