require 'rails_helper'

RSpec.describe User do
  it 'can have more then one interest' do
    user = create(:user)
    Interest.new(name: 'flying', type: 'work', user_id: user.id).save
    Interest.new(name: 'jokes', type: 'hobby', user_id: user.id).save

    user.reload

    expect(user.interests.count).to eq 2
  end

  describe '#to_csv' do
    it 'returns all users data' do
      user = create(:user, email: 'example@mail.com', is_male: true)
      create(:interest, user: user, name: 'ruby')
      create(:interest, user: user, name: 'rails')

      expect(User.to_csv).to eq "id,email,gender,age,interests_list\n1,example@mail.com,male,23,\"ruby, rails""\"\n"
    end
  end

  describe '#age' do
    context 'when user did not have a birthday this year' do
      it 'returns the current age in years of a given user' do
        travel_to Date.new(2018, 1, 30) do
          user = create(:user, birthday: '1994-08-21')

          expect(user.age).to eq 23
        end
      end
    end

    context 'when user did have a birthday this year' do
      it 'returns the current age in years of a given user' do
        travel_to Date.new(2018, 9, 11) do
          user = create(:user, birthday: '1994-08-21')

          expect(user.age).to eq 24
        end
      end
    end
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
    context 'when user is female' do
      it "returns 'female'" do
        user = create(:user, is_male: false)

        expect(user.gender).to eq 'female'
      end
    end

    context 'when user is male' do
      it "returns 'male'" do
        user = create(:user, is_male: true)

        expect(user.gender).to eq 'male'
      end
    end
  end
end
