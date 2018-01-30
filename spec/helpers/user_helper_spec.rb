require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe UsersHelper do
  describe '#user_age' do
    context "when today's date is 2018-01-30 and user was born in 1994-08-21" do
      it 'return 23' do
        travel_to Date.new(2018, 1, 30) do
          user = create(:user, birthday: '1994-08-21')

          expect(user_age(user)).to eq 23
        end
      end
    end

    context "when today's date is 2018-01-30 and user was born in 1994-08-21" do
      it 'return 24' do
        travel_to Date.new(2018, 9, 11) do
          user = create(:user, birthday: '1994-08-21')

          expect(user_age(user)).to eq 24
        end
      end
    end
  end
end
