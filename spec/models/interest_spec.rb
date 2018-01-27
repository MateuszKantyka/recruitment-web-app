require "rails_helper"

RSpec.describe Interest do
  it 'has none to begin with' do
    expect(Interest.count).to eq 0
  end
end
