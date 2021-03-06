require 'rails_helper'

RSpec.feature 'Session' do
  scenario 'user can log in and log out' do
    create(:user, email: 'example@mail.com', password: '12345678')

    visit root_path
    fill_in :user_email, with: 'example@mail.com'
    fill_in :user_password, with: '12345678'
    click_on 'Log in'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Log out'
    expect(page).to have_content 'example@mail.com'
    expect(page).to have_content 'Signed in successfully.'

    click_on 'Log out'

    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'logged user visits root path' do
    user = create(:user, email: 'example@mail.com')
    sign_in user

    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Log out'
    expect(page).to have_content 'example@mail.com'
  end
end
