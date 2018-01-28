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
