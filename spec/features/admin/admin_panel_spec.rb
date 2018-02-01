require 'rails_helper'

RSpec.feature 'Admin' do
  scenario 'admin can create a new user' do
    admin = create(:user, admin: true)
    sign_in admin

    visit admins_path
    page.check('new_user')
    fill_in :user_email, with: 'example@mail.com'
    select('Male', from: 'gender')
    fill_in :user_birthday, with: '1994-08-21'
    click_on 'Save'

    expect(current_path).to eq admins_path
    expect(page).to have_content 'User successfully created'
  end

  scenario 'admin can update a user' do
    admin = create(:user, admin: true)
    create(:user, email: 'example@mail.com', is_male: true)
    sign_in admin

    visit admins_path
    page.check('existing_user')
    select('example@mail.com', from: 'users_list')
    select('Female', from: 'gender')
    click_on 'Save'

    expect(current_path).to eq admins_path
    expect(page).to have_content 'User successfully updated'
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
