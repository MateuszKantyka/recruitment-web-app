require 'rails_helper'

RSpec.describe Interest do
  it 'can have type only from predefined category: health, hobby, work' do
    user = create(:user)
    Interest.new(name: 'Ruby', type: 'work', user_id: user.id).save
    Interest.new(name: 'Jokes', type: 'hobby', user_id: user.id).save
    Interest.new(name: 'Football', type: 'health', user_id: user.id).save

    expect(user.interests.count).to eq 3
  end
end
