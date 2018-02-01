require 'rails_helper'

RSpec.describe AdminsController do
  describe '#index' do
    context 'when user is admin' do
      it 'renders admin panel page' do
        admin = create(:user, admin: true)
        sign_in admin

        get :index

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not admin' do
      it 'redirects to users index page' do
        user = create(:user, admin: false)
        sign_in user

        get :index

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(users_path)
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
end
