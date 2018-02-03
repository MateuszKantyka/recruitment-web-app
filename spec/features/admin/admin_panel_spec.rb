require 'rails_helper'

RSpec.feature 'Admin' do
  scenario 'admin can create a new user' do
    admin = create(:user, admin: true)
    sign_in admin

    visit admins_path
    click_on 'New User'
    fill_in :user_email, with: 'example@mail.com'
    fill_in :user_gender, with: 'Male'
    fill_in :user_birthday, with: '1994-08-21'
    click_on 'Create User'

    expect(current_path).to eq admins_path
    expect(page).to have_content user.email
    expect(page).to have_content 'User created'
  end

  scenario 'admin can edit a user' do
    admin = create(:user, admin: true)
    user = create(:user, email: 'example@mail.com')
    sign_in admin

    visit admins_path
    click_on user.email
    fill_in :user_email, with: 'user-mail@mail.com'
    click_on 'Update User'

    expect(current_path).to eq admins_path
    expect(page).to have_content user.email
    expect(page).to have_content 'User updated'
  end

  scenario 'admin can deleting or adding interest to a user' do
    admin = create(:user, admin: true)
    user = create(:user, email: 'example@mail.com')
    create(:interest, name: 'Ruby', user_id: user.id)
    sign_in admin

    visit admins_path
    page.check('existing_user')
    select('example@mail.com', from: 'users_list')
    select('Ruby', from: 'interests_list')
    click_on 'Delete interest'
    fill_in :interest_name, with: 'Rails'
    select('Work', from: 'interests_type')
    click_on 'Add interest'

    expect(current_path).to eq admins_path
  end
end
