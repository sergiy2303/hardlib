require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:attachment) { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/books/default.pdf'))) }
  let(:category) { create(:category) }
  let(:category_2) { create(:category) }
  before do
    sign_in user
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
        sign_out user

        get :index

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when logget in' do
      it 'returns http success and render new' do
        xhr :get, :new, js: true

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out user

        get :new

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when logget in' do
      # it 'should create book' do
      #   expect(Book.all.count).to be(0)

      #   xhr :post, :create, book: { title: 'Test', pages: '20', year: '2015', attachment: attachment, category_ids: [category.id] }, js: true

      #   user_book = user.books.first
      #   expect(response).to have_http_status(:success)
      #   expect(user.books.count).to be(1)
      #   expect(user_book.title).to eq('Test')
      #   expect(user_book.pages).to be(20)
      #   expect(user_book.year).to be(2015)
      #   expect(user_book.attachment_url).to include('default.pdf')
      #   expect(user_book.category_ids.count).to be(1)
      # end

      # it 'should allow to add multiple categories' do
      #   expect(Book.all.count).to be(0)

      #   xhr :post, :create, book: { title: 'Test', pages: '20', year: '2015', attachment: attachment, category_ids: [category.id, category_2.id] }, js: true

      #   user_book = user.books.first
      #   expect(response).to have_http_status(:success)
      #   expect(user.books.count).to be(1)
      #   expect(user_book.title).to eq('Test')
      #   expect(user_book.pages).to be(20)
      #   expect(user_book.year).to be(2015)
      #   expect(user_book.attachment_url).to include('default.pdf')
      #   expect(user_book.category_ids.count).to be(2)
      # end

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

      it 'should not create book with too long title' do
        expect(Book.all.count).to be(0)
        title = '12' * 26

        xhr :post, :create, book: { title: title, pages: '20', year: '2015', attachment: attachment, category_ids: [category.id] }, js: true

        expect(response).to have_http_status(:success)
        expect(user.books.count).to be(0)
      end

      it 'should not create book with too long description' do
        expect(Book.all.count).to be(0)
        description = '1234' * 251

        xhr :post, :create, book: { title: 'title', pages: '20', year: '2015', description: description, attachment: attachment, category_ids: [category.id] }, js: true

        expect(response).to have_http_status(:success)
        expect(user.books.count).to be(0)
      end
    end

    context 'when logget out' do
      it 'Unauthenticated user should be redirected' do
        sign_out user

        post :create

        expect(response.status).to be(302)
        expect(response).to redirect_to(access_denied_path)
      end
    end
  end
end
