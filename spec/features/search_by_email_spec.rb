require 'rails_helper'

RSpec.feature 'Search' do
  scenario 'user can scope the listing by inputing the email' do
    user = create(:user, email: 'example@mail.com')
    create(:user, email: 'example_mail_2@mail.com')
    create(:user, email: 'example_mail_3@mail.com')
    sign_in user

    visit root_path
    fill_in :q_email_cont, with: 'example@mail.com'
    click_on 'Search'

    expect(page).to have_content 'example@mail.com'
    expect(page).not_to have_content 'example_mail_2@mail.com'
    expect(page).not_to have_content 'example_mail_3@mail.com'
  end
end