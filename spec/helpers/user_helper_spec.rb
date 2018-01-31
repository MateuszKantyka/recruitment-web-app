require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

RSpec.describe UsersHelper do
  describe '#user_age' do
    context "when user did not have a birthday this year" do
      it 'it returns the current age in years of a given user' do
        travel_to Date.new(2018, 1, 30) do
          user = create(:user, birthday: '1994-08-21')

          expect(user_age(user)).to eq 23
        end
      end
    end

    context "when user did have a birthday this year" do
      it 'it returns the current age in years of a given user' do
        travel_to Date.new(2018, 9, 11) do
          user = create(:user, birthday: '1994-08-21')

          expect(user_age(user)).to eq 24
        end
      end
    end
  end
end
