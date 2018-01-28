require "rails_helper"

RSpec.describe User do
  it 'has none to begin with' do
    expect(User.count).to eq 0
  end

  it 'has a valid Factory' do
    create(:user)

    expect(User.count).to eq 1
  end

  it 'can by created with valid arguments' do
    user = User.new(email:'example@mail.com',
                    password:'qwerty',
                    is_male: true,
                    admin: false).save

    expect(User.count).to eq 1
  end

  it 'can have more then one interest' do
    user = create(:user)
    interest = Interest.new(name: 'flying', type: 'Work', user_id: user.id).save
    interest1 = Interest.new(name: 'jokes', type: 'Hobby', user_id: user.id).save

    user.reload

    expect(user.interests.count).to eq 2
  end
end
