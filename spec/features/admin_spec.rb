require 'rails_helper'

RSpec.feature 'Session' do
  scenario 'admin can display admin panel' do
    admin = create(:user, admin: true)
    sign_in admin

    visit root_path
    click_on 'Admin panel'

    expect(current_path).to eq admin_panel_path
    expect(page).to have_content 'Admin panel'
  end
end
