require 'rails_helper'

RSpec.feature 'Search' do
  scenario 'user can set scope the listing by inputing the email' do
    user = (:user, email: 'example@mail.com')
    (:user, email: 'example_mail_2@mail.com')
    (:user, email: 'example_mail_3@mail.com')
    sign_in user

    visit root_path
    fill_in :search_field_email, with: 'example@mail.com'
    click_on 'Search'

    expect(page).to have_content 'example@mail.com'
    expect(page).not_to have_content 'example_mail_2@mail.com'
    expect(page).not_to have_content 'example_mail_3@mail.com'
  end
end