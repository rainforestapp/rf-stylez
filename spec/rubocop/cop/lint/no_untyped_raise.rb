# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoUntypedRaise do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when untyped raise' do
    expect_offense(<<-RUBY.strip_indent)
      def foo
        raise 'foo'
        ^^^^^^^^^^^ Do not raise untyped exceptions
      end
    RUBY
  end

  describe 'when raise is typed' do
    it 'registers no offense' do
      expect_no_offenses(<<-RUBY.strip_indent)
        def foo
          raise ArgumentError, 'foo'
        end
      RUBY
    end
  end
end
