require 'rails_helper'

RSpec.feature '' do
  scenario 'user sends greetings mail' do
    admin = create(:user)
    user = create(:user, email: 'user@test.com')
    sign_in admin

    visit root_path
    find(:id, "mail_icon_#{user.id}").click

    expect(page).to have_content 'The mail is sent to the User: user@test.com'
  end
end