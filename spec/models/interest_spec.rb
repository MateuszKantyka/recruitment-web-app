require 'rails_helper'

RSpec.describe Interest do
  it 'can have type only from predefined category: health, hobby, work' do
    user = create(:user)
    Interest.create(name: 'Ruby', type: 'work', user_id: user.id)
    Interest.create(name: 'Jokes', type: 'hobby', user_id: user.id)
    Interest.create(name: 'Football', type: 'health', user_id: user.id)
    
    expect { Interest.create(name: 'C++', type: 'programing', user_id: user.id) }.to raise_error(ArgumentError)
    expect(user.interests.count).to eq 3
  end
end
