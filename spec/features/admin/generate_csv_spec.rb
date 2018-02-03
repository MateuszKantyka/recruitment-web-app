require 'rails_helper'

RSpec.feature 'Admin' do
  scenario 'admin can generate csv file' do
    admin = create(:user, admin: true)
    sign_in admin

    visit root_path
    click_on 'Export to CSV'

    expect(current_path).to eq "#{users_path}.csv"
  end
end
