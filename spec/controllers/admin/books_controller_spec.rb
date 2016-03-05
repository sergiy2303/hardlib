require 'rails_helper'

RSpec.describe Admin::BooksController, type: :controller do
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
      it 'user should be redirected' do
        sign_in user

        get :index

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logget in' do
      it 'should destroy book' do
        @book = create(:book, user: user)
        expect(Book.all.count).to be(1)

        xhr :delete, :destroy, id: @book.id, js: true

        expect(response).to have_http_status(:success)
        expect(Book.all.count).to be(0)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out admin
        @book = create(:book, user: user)
        expect(Book.all.count).to be(1)

        xhr :delete, :destroy, id: @book.id, js: true

        expect(response.status).to be(302)
        expect(Book.all.count).to be(1)
      end
    end

    context 'when not admin' do
      it 'Should redirect user to access denied page' do
        sign_in user
        @book = create(:book, user: user)
        expect(Book.all.count).to be(1)

        xhr :delete, :destroy, id: @book.id, js: true

        expect(response.status).to be(302)
        expect(Book.all.count).to be(1)
      end
    end
  end
end
