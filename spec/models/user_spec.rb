require 'rails_helper'

RSpec.describe User do
  it 'can have more then one interest' do
    user = create(:user)
    Interest.new(name: 'flying', type: 'Work', user_id: user.id).save
    Interest.new(name: 'jokes', type: 'Hobby', user_id: user.id).save

    user.reload

    expect(user.interests.count).to eq 2
  end

  describe '#interests_list' do
    it 'returns user interests list' do
      user = create(:user)
      create(:interest, user: user, name: 'Rails')
      create(:interest, user: user, name: 'Ruby')

      expect(user.interests_list).to eq 'Rails, Ruby'
    end
  end

  describe '#gender' do
    context 'when user is_male field equal false' do
      it "returns 'female'" do
        user = create(:user, is_male: false)

        expect(user.gender).to eq 'female'
      end
    end

    context 'when user is_male field equal true' do
      it "returns 'male'" do
        user = create(:user, is_male: true)

        expect(user.gender).to eq 'male'
      end
    end
  end
end
