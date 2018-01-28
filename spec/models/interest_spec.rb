require 'rails_helper'

RSpec.describe Interest do
  it 'has none to begin with' do
    expect(Interest.count).to eq 0
  end

  it 'can by created with valid arguments' do
    user = create(:user)
    Interest.new(name: 'jokes', type: 'Hobby', user_id: user.id).save

    expect(Interest.count).to eq 1
  end
end
