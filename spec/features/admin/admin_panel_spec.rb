require 'rails_helper'

RSpec.feature 'Admin' do
  scenario 'admin can create a new user' do
    admin = create(:user, admin: true)
    sign_in admin

    visit admins_path
    click_on 'New User'
    fill_in :user_email, with: 'example@mail.com'
    select('Male', from: 'user_is_male')
    select('1994', from: 'user_birthday_1i')
    select('February', from: 'user_birthday_2i')
    select('28', from: 'user_birthday_3i')
    click_on 'Save'

    expect(current_path).to eq admins_path
    expect(page).to have_content 'example@mail.com'
    expect(page).to have_content 'User created'
  end

  scenario 'admin can edit a user' do
    admin = create(:user, admin: true)
    user = create(:user, email: 'example@mail.com')
    sign_in admin

    visit admins_path
    click_on user.email
    fill_in :user_email, with: 'user-mail@mail.com'
    click_on 'Save'

    expect(current_path).to eq admins_path
    expect(page).to have_content 'user-mail@mail.com'
    expect(page).to have_content 'User updated'
  end

  scenario 'admin can deleting or adding interest to a user' do
    admin = create(:user, admin: true)
    user = create(:user, email: 'example@mail.com')
    create(:interest, name: 'Ruby', user_id: user.id)
    sign_in admin

    visit admins_path
    click_on user.email
    click_on 'remove interest'
    click_on 'add interest'
    fill_in :user_interests_attributes_0_name, with: 'Rails'
    select('Work', from: 'user_interests_attributes_0_type')
    click_on 'Save'

    expect(user.interests.first.name).to eq 'Rails'
    expect(current_path).to eq admins_path
  end
end