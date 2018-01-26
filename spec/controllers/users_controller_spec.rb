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
end
