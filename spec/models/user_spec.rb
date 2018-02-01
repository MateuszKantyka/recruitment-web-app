require 'rails_helper'

RSpec.describe User do
  it 'can have more then one interest' do
    user = create(:user)
    Interest.new(name: 'flying', type: 'Work', user_id: user.id).save
    Interest.new(name: 'jokes', type: 'Hobby', user_id: user.id).save

    user.reload

    expect(user.interests.count).to eq 2
  end
end
