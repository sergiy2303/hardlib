require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:attachment) { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/books/default.pdf'))) }
  let(:category) { create(:category) }
  context 'signed in' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'returns http success and render index' do
        get :index
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end

      it 'Unauthenticated user should be redirected' do
        sign_out user
        get :index
        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end

    describe 'GET #new' do
      it 'returns http success and render new' do
        xhr :get, :new, js: true
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
      end

      it 'Unauthenticated user should be redirected' do
        sign_out user
        get :new
        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end

    describe 'POST #create' do
      it 'should create book for authenticated user' do
        expect(Book.all.count).to be(0)
        xhr :post, :create, book: { title: 'Test', pages: '20', year: '2015', attachment: attachment, category_ids: [category.id] }, js: true

        user_book = user.books.first
        expect(response).to have_http_status(:success)
        expect(user.books.count).to be(1)
        expect(user_book.title).to eq('Test')
        expect(user_book.pages).to be(20)
        expect(user_book.year).to be(2015)
        expect(user_book.attachment_url).to include('default.pdf')
      end

      it 'should not create book without attachment' do
        expect(Book.all.count).to be(0)
        xhr :post, :create, book: { title: 'Test', pages: '20', year: '2015', category_ids: [category.id] }, js: true

        expect(response).to have_http_status(:success)
        expect(user.books.count).to be(0)
      end

      it 'should not create book without category' do
        expect(Book.all.count).to be(0)
        xhr :post, :create, book: { title: 'Test', pages: '20', year: '2015', attachment: attachment }, js: true

        expect(response).to have_http_status(:success)
        expect(user.books.count).to be(0)
      end

      it 'should not create book without title' do
        expect(Book.all.count).to be(0)
        xhr :post, :create, book: { pages: '20', year: '2015', attachment: attachment, category_ids: [category.id] }, js: true

        expect(response).to have_http_status(:success)
        expect(user.books.count).to be(0)
      end

      it 'Unauthenticated user should be redirected' do
        sign_out user
        post :create
        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end

    describe 'GET #destroy' do
      it 'should destroy book for authenticated user' do
        @book = create(:book, user: user)
        expect(Book.all.count).to be(1)

        xhr :delete, :destroy, id: @book.id, js: true

        expect(response).to have_http_status(:success)
        expect(Book.all.count).to be(0)
      end

      it 'Unauthenticated user should be redirected' do
        sign_out user
        @book = create(:book, user: user)
        expect(Book.all.count).to be(1)

        xhr :delete, :destroy, id: @book.id, js: true

        expect(response.status).to be(302)
        expect(Book.all.count).to be(1)
      end

      it 'should not delete book of another user' do
        @book = create(:book)
        expect(Book.all.count).to be(1)

        xhr :delete, :destroy, id: @book.id, js: true

        expect(response.status).to be(200)
        expect(Book.all.count).to be(1)
      end
    end
  end
end
