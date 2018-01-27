require 'rails_helper'

RSpec.feature 'Admin' do
  scenario 'admin can delete user' do
    admin = create(:user, admin: true)
    create(:user, email: "example-user@mail.com")
    sign_in admin

    visit root_path
    find(:xpath, "//a[@href='/users/2']").click

    expect(current_path).to eq users_path
    expect(page).to have_content 'User successfully destroyed'
    expect(page).not_to have_content 'example-user@mail.com'
  end
end
