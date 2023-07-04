# frozen_string_literal: true

describe RuboCop::Cop::Lint::NoVCRRecording do
  let(:config) { RuboCop::Config.new }
  subject(:cop) { described_class.new(config) }

  it 'registers an offense when using vcr: { record: ... }' do
    expect_offense(<<~RUBY)
      describe Foo, vcr: { record: :new_episodes } do
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Lint/NoVCRRecording: Do not set :record option in VCR
        include_examples 'all the networks!'
      end
    RUBY

    expect_correction(<<~RUBY)
      describe Foo, vcr: true do
        include_examples 'all the networks!'
      end
    RUBY
  end

  it 'handles multiple options passed to vcr' do
    expect_offense(<<~RUBY)
      it 'works!', vcr: { tag: :workworkwork, record: :once } do
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Lint/NoVCRRecording: Do not set :record option in VCR
        expect(let_me_google_that_for_you).to be_full_of_sass
      end
    RUBY

    expect_correction(<<~RUBY)
      it 'works!', vcr: { tag: :workworkwork } do
        expect(let_me_google_that_for_you).to be_full_of_sass
      end
    RUBY
  end

  it 'does not register an offense when not using :record' do
    expect_no_offenses(<<~RUBY)
      context 'with no recording', vcr: true do
        specify { expect(true).to eq(true) }
      end
    RUBY

    expect_no_offenses(<<~RUBY)
      context 'with no recording', vcr: { match_requests_on: [:request, :path] } do
        specify { expect(false).to eq(false) }
      end
    RUBY
  end
end
