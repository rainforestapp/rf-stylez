# frozen_string_literal: true

RSpec.describe Rf::Stylez do
  it "config should be valid" do
    expect do
      RuboCop::ConfigLoader.load_file("ruby/rubocop.yml")
    end.not_to raise_error
  end
end
