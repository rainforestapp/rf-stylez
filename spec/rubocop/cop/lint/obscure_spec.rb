# frozen_string_literal: true

describe RuboCop::Cop::Lint::Obscure do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using flipflop' do
    expect_offense(<<~RUBY)
      puts 'foo' if 'a'..'b'
                    ^^^^^^^^ Lint/Obscure: Do not use the flipflop operator
    RUBY
  end

  it 'registers an offense when using eflipflop' do
    expect_offense(<<~RUBY)
      puts 'foo' if 'a'...'b'
                    ^^^^^^^^^ Lint/Obscure: Do not use the flipflop operator
    RUBY
  end

  it 'registers an offense when using String#%' do
    expect_offense(<<~RUBY)
      puts 'foo' % 'bar'
           ^^^^^^^^^^^^^ Lint/Obscure: Do not use String#%
    RUBY
  end

  it 'does not register an offense when using incluse Range `..`' do
    expect_no_offenses(<<~RUBY)
      1..2
    RUBY
  end

  it 'does not register an offense when using exclusive Range `...`' do
    expect_no_offenses(<<~RUBY)
      1...2
    RUBY
  end
end
