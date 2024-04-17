# frozen_string_literal: true

RSpec.describe Rf::Stylez do
  it "config should be valid" do
    expect do
      RuboCop::ConfigLoader.load_file("ruby/rubocop.yml")
    end.to_not raise_error
  end
end
