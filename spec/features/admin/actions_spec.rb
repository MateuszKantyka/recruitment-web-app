require 'rails_helper'

RSpec.feature 'Admin' do
  scenario 'admin can delete user' do
    admin = create(:user, admin: true)
    user = create(:user, email: 'example-user@mail.com')
    sign_in admin

    visit root_path
    find(:id, "trash_icon_#{user.id}").click

    expect(current_path).to eq users_path
    expect(page).to have_content 'User successfully destroyed'
    expect(page).not_to have_content 'example-user@mail.com'
  end

  scenario 'admin can delete user with interests' do
    admin = create(:user, admin: true)
    user = create(:user, email: 'example-user@mail.com')
    create(:interest, user_id: user.id)
    create(:interest, user_id: user.id)
    sign_in admin

    visit root_path
    find(:id, "trash_icon_#{user.id}").click

    expect(current_path).to eq users_path
    expect(page).to have_content 'User successfully destroyed'
    expect(page).not_to have_content 'example-user@mail.com'
  end
end
