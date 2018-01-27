require "rails_helper"

RSpec.describe User do
  it 'has none to begin with' do
    expect(User.count).to eq 0
  end
  
  it 'is valid with valid attributes' do
    expect(create(:user)).to be_valid
  end
end
