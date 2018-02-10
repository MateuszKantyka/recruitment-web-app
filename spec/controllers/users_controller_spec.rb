require 'rails_helper'

RSpec.describe UsersController do
  describe '#index' do
    context 'when user is logged' do
      it 'renders index page' do
        user = create(:user)
        sign_in user

        get :index

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not logged' do
      it 'redirects to sign up page' do
        get :index

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when admin is logged and want to generate csv file' do
      it 'generates csv file with user data' do
        admin = create(:user, admin: true, email: 'example-admin-mail@mail.com', is_male: true, birthday: '1994-08-21')
        user = create(:user, email: 'example-user-mail@mail.com')
        create(:interest, user: admin, name: 'ruby')
        sign_in admin

        get :index, format: :csv
        parsed_response = CSV.parse(response.body)
        admin_in_response = parsed_response.find { |row| row[1] == 'example-admin-mail@mail.com' }
        user_in_response = parsed_response.find { |row| row[1] == 'example-user-mail@mail.com' }

        expect(parsed_response[0]).to contain_exactly('id', 'email', 'gender', 'age', 'interests_list')
        expect(admin_in_response).to contain_exactly(admin.id.to_s, 'example-admin-mail@mail.com', 'male', admin.age.to_s, "ruby")
        expect(user_in_response).to contain_exactly(user.id.to_s, 'example-user-mail@mail.com', 'male', user.age.to_s, "")
      end
    end
  end

  describe '#destroy' do
    context 'when admin wants to remove another user' do
      it 'deletes user from database and refresh index page' do
        user = create(:user)
        admin = create(:user, admin: true)
        sign_in admin

        delete(:destroy, params: { id: user.id })

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(users_path)
        expect(User.count).to eq 1
        expect(flash[:success]).to eq 'User successfully destroyed'
      end
    end

    context 'when user have two interests' do
      it 'deletes user from database and refresh index page' do
        user = create(:user)
        create(:interest, user_id: user.id)
        create(:interest, user_id: user.id)
        admin = create(:user, admin: true)
        sign_in admin

        delete(:destroy, params: { id: user.id })

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(users_path)
        expect(User.count).to eq 1
        expect(flash[:success]).to eq 'User successfully destroyed'
      end
    end

    context 'when admin wants to remove himself' do
      it 'display error message and refresh index page' do
        admin = create(:user, admin: true)
        sign_in admin

        delete(:destroy, params: { id: admin.id })

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(users_path)
        expect(User.first).to eq admin
        expect(flash[:danger]).to eq "Admin can't remove himself"
      end
    end
  end
end
