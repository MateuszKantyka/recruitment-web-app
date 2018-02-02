require "rails_helper"

RSpec.describe InterestsQuery do
  describe '#call' do
    it 'returns the current number interests type "health", with name
        beginning with ,,cosm'' choosen by women aged between 20 and 30' do
      user_nr_1 = create(:user, is_male: false, birthday: Date.current-25.year)
      create(:interest, user_id: user_nr_1.id, type: 'health', name: 'cosmos')
      create(:interest, user_id: user_nr_1.id, type: 'health', name: 'cosmetics')
      user_nr_2 = create(:user, is_male: false, birthday: Date.current-22.year)
      create(:interest, user_id: user_nr_2.id, type: 'health', name: 'cosmetics')
      create(:interest, user_id: user_nr_2.id, type: 'work', name: 'ruby')

      expect(InterestsQuery.call).to eq 3
    end
  end
end
