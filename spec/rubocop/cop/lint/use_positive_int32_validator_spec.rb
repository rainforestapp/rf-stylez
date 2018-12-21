# frozen_string_literal: true

describe RuboCop::Cop::Lint::UsePositiveInt32Validator do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  ['requires','optional'].each do |method|
    context 'registers an offense when not validating Integers in a Grape API `#{method}`' do
      it "standard" do
        expect_offense(<<-RUBY.strip_indent)
          params do
            #{method} :id, type: Integer, desc: 'Comment ID'
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          end
        RUBY
      end

      it "order doesn't matter" do
        expect_offense(<<-RUBY.strip_indent)
          params do
            #{method} :id, desc: 'Comment ID', type: Integer
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          end
        RUBY
      end

      it "multiple args" do
        expect_offense(<<-RUBY.strip_indent)
        params do
          #{method} :id, type: Integer, desc: 'Comment ID'
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          requires :text, type: String
        end
        RUBY
      end

      it "multiple args, mixed order" do
        expect_offense(<<-RUBY.strip_indent)
        params do
          requires :text, type: String
          #{method} :id, type: Integer, desc: 'Comment ID'
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
          requires :text, type: String
          requires :id2, type: Integer, desc: 'Comment ID'
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
        end
        RUBY
      end

      it "named params block" do
        expect_offense(<<-RUBY.strip_indent)
        params :test do
          #{method} :id, type: Integer, desc: 'Comment ID'
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ If this Integer maps to a postgres Integer column, validate with `positive_int32: true`
        end
        RUBY
      end
    end

    it 'does not register an offense when not in a params block' do
      expect_no_offenses(<<-RUBY.strip_indent)
        #{method} :id, type: Integer, desc: 'Comment ID'
      RUBY
    end

    context 'does not register an offense when positive_int32 is true' do
      it 'standard' do
        expect_no_offenses(<<-RUBY.strip_indent)
          params :test do
            #{method} :id, type: Integer, desc: 'Comment ID', positive_int32: true
          end
        RUBY
      end

      it 'with a bunch of args' do
        expect_no_offenses(<<-RUBY.strip_indent)
          params :test do
            #{method} :id, type: Integer, desc: 'Comment ID', documentation: { blah: 'blah' }, positive_int32: true
          end
        RUBY
      end
    end
  end
end
