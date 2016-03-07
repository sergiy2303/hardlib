require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }

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
      it 'returns http success and render index' do
        sign_out user

        get :index

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #access_denied' do
    context 'when logget in' do
      it 'returns http success and render index' do
        get :access_denied

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:access_denied)
      end
    end

    context 'when logget out' do
      it 'returns http success and render index' do
        sign_out user

        get :access_denied

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:access_denied)
      end
    end
  end
end
