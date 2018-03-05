require 'rails_helper'

RSpec.feature 'SendingMail' do
  scenario 'user sends greetings mail' do
    admin = create(:user)
    user = create(:user, email: 'user@test.com')
    sign_in admin

    visit root_path
    find(:id, "mail_icon_#{user.id}").click

    expect(page).to have_content 'The mail is sent to the User: user@test.com'
  end

  scenario 'user sends mail to all users' do
    user = create(:user)
    sign_in user

    visit root_path
    click_on 'Send mail to all users'

    expect(page).to have_content 'The mail is sent to the all users'
  end
end