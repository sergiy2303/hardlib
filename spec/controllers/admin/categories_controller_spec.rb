require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:category) { create(:category) }
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

  describe 'POST #create' do
    context 'when logget in' do
      it 'should create category' do
        expect(Category.all.count).to be(0)

        xhr :post, :create, category: { title: 'Test' }, js: true

        expect(response).to have_http_status(:success)
        expect(Category.all.count).to be(1)
        expect(Category.last.title).to eq('Test')
      end

      it 'should not create category without title' do
        expect(Category.all.count).to be(0)

        xhr :post, :create, category: { title: '' }, js: true

        expect(response).to have_http_status(:success)
        expect(Category.all.count).to be(0)
        expect(response).to render_template(:create)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin

        post :create

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end

    context 'when not admin' do
      it 'user should be redirected' do
        sign_in user

        post :create

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logget in' do
      it 'should destroy category' do
        expect(category)
        expect(Category.all.count).to be(1)

        xhr :delete, :destroy, id: category.id, js: true

        expect(response).to have_http_status(:success)
        expect(Category.all.count).to be(0)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin
        expect(category)
        expect(Category.all.count).to be(1)

        xhr :delete, :destroy, id: category.id, js: true

        expect(response.status).to be(302)
        expect(Category.all.count).to be(1)
      end
    end

    context 'when not admin' do
      it 'user should be redirected' do
        sign_out admin
        expect(category)
        expect(Category.all.count).to be(1)

        xhr :delete, :destroy, id: category.id, js: true

        expect(response.status).to be(302)
        expect(Category.all.count).to be(1)
      end
    end
  end

  describe 'GET #edit' do
    context 'when logget in' do
      it 'returns http success and render edit' do
        xhr :get, :edit, id: category.id, js: true

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin

        xhr :get, :edit, id: category.id, js: true

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end

    context 'when not admin' do
      it 'user should be redirected' do
        sign_out user

        xhr :get, :edit, id: category.id, js: true

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end

  describe 'POST #update' do
    context 'when logget in' do
      it 'should update category' do
        expect(category)

        xhr :post, :update, id: category.id, category: { title: 'Some title' }, js: true

        category.reload
        expect(response).to have_http_status(:success)
        expect(category.title).to eq('Some title')
      end

      it 'should not update category' do
        title = category.title

        xhr :post, :update, id: category.id, category: { title: '' }, js: true

        category.reload
        expect(response).to have_http_status(:success)
        expect(category.title).to eq(title)
        expect(response).to render_template(:edit)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin
        title = category.title

        xhr :post, :update, id: category.id, category: { title: 'Some title' }, js: true

        expect(response.status).to be(302)
        expect(category.title).to eq(title)
      end
    end

    context 'when not admin' do
      it 'user should be redirected' do
        sign_in user
        title = category.title

        xhr :post, :update, id: category.id, category: { title: 'Some title' }, js: true

        expect(response.status).to be(302)
        expect(category.title).to eq(title)
      end
    end
  end
end
