require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      pending
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      pending
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      pending
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      pending
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
