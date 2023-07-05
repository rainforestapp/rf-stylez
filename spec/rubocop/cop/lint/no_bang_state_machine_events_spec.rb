# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoBangStateMachineEvents do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers event names ending with a !' do
    expect_offense(<<~RUBY)
      state_machine :state do
        event :started! do
        ^^^^^^^^^^^^^^^ Lint/NoBangStateMachineEvents: Event names ending with a `!` define `!`-ended methods that do not raise
          transition :queued => :in_progress
        end
      end
    RUBY
  end

  it 'does not register event names without a !' do
    expect_no_offenses(<<~RUBY)
      state_machine :state do
        event :started do
          transition :queued => :in_progress
        end
      end
    RUBY
  end

  it 'does not register call to event outside of state machine' do
    expect_no_offenses(<<~RUBY)
      class SomethingElse
        event :started! do
          transition :queued => :in_progress
        end
      end
    RUBY
  end
end
