require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  before do
    sign_in admin
  end

  describe 'GET #index' do
    context 'when logget in' do
      it 'returns http success and render index' do
        get :index

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin

        get :index

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end

    context 'when not admin' do
      it 'Uuser should be redirected' do
        sign_in user

        get :index

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end

  describe 'GET #show' do
    context 'when logget in' do
      it 'returns http success and render show' do
        get :show, email: user.email

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end

      it 'returns http success and render show when user not found' do
        get :show, email: 'some email'

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin

        get :show, email: user.email

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end

    context 'when not admin' do
      it 'Uuser should be redirected' do
        sign_in user

        get :show, email: user.email

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logget in' do
      it 'should destroy user' do
        expect(user)
        expect(User.all.count).to be(2)

        xhr :delete, :destroy, id: user.id, js: true

        expect(response).to have_http_status(:success)
        expect(User.all.count).to be(1)
        expect(User.first.admin).to be_truthy
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin
        expect(user)
        expect(User.all.count).to be(2)

        xhr :delete, :destroy, id: user.id, js: true

        expect(response.status).to be(302)
        expect(User.all.count).to be(2)
      end
    end

    context 'when not admin' do
      it 'user should be redirected' do
        sign_in user
        expect(user)
        expect(User.all.count).to be(2)

        xhr :delete, :destroy, id: user.id, js: true

        expect(response.status).to be(302)
        expect(User.all.count).to be(2)
        expect(User.all.count).to be(2)
      end
    end
  end

  describe 'GET #edit' do
    context 'when logget in' do
      it 'returns http success and render edit' do
        xhr :get, :edit, id: user.id, js: true

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin

        xhr :get, :edit, id: user.id, js: true

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end

    context 'when not admin' do
      it 'user should be redirected' do
        sign_in user

        xhr :get, :edit, id: user.id, js: true

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end

  describe 'POST #update' do
    context 'when logget in' do
      it 'should update user' do
        expect(user)

        xhr :post, :update, id: user.id, user: { first_name: 'Evan' }, js: true

        user.reload
        expect(response).to have_http_status(:success)
        expect(user.first_name).to eq('Evan')
      end

      it 'should not update user' do
        name = user.first_name

        xhr :post, :update, id: user.id, user: { first_name: '' }, js: true

        user.reload
        expect(response).to have_http_status(:success)
        expect(user.first_name).to eq(name)
        expect(response).to render_template(:edit)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin
        name = user.first_name

        xhr :post, :update, id: user.id, user: { first_name: 'Evan' }, js: true

        expect(response.status).to be(302)
        expect(user.first_name).to eq(name)
      end
    end

    context 'when not admin' do
      it 'user should be redirected' do
        sign_in user
        name = user.first_name

        xhr :post, :update, id: user.id, user: { first_name: 'Evan' }, js: true

        expect(response.status).to be(302)
        expect(user.first_name).to eq(name)
      end
    end
  end
end
