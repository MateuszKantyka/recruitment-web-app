require 'rails_helper'

RSpec.describe UsersHelper do
  describe '#user_age' do
    context "when user was born in 1994-08-21" do
      it 'return 23' do
        result = user_age(create(:user, birthday: '1994-08-21'))

        expect(result).to eq 23
      end
    end

    context "when user was born in 1994-01-11" do
      it 'return 24' do
        result = user_age(create(:user, birthday: '1994-01-11'))

        expect(result).to eq 24
      end
    end
  end
end
