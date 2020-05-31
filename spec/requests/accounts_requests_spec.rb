require 'rails_helper'

describe Api::V1::AccountsController, type: :controller do
  describe 'POST #create' do
    context 'when the request is correct' do
      it 'returns http success and account info', :aggregate_failures do
        request_params = {
          id: 123,
          name: 'Franklin Clinton',
          balance: '11600'
        }
        post :create, params: request_params
        body = JSON.parse(response.body)
        expect(body['id']).to eq(123)
        expect(response).to have_http_status(:success)

        expect(Account.last).to have_attributes(
          id: 123,
          name: 'Franklin Clinton',
          balance: 11_600
        )
      end
    end

    context 'when a request has duplicated id' do
      it 'returns http conflict status' do
        create(:account, id: 123)
        request_params = {
          id: 123,
          name: 'Franklin Clinton',
          balance: '11600'
        }

        post :create, params: request_params
        expect(response).to have_http_status(:conflict)
      end
    end
  end

  describe 'GET #show' do
    context 'when the request is correct' do
      it 'returns http success and account balance', :aggregate_failures do
        create(:account, id: 123, balance: 10_000)
        request_params = {
          id: 123
        }

        get :show, params: request_params

        expect(response).to have_http_status(:success)
        expect(response.body).to eq('Saldo de 10000 na conta')
      end
    end

    context 'when the account does not exist' do
      it 'returns http success and account balance', :aggregate_failures do
        request_params = {
          id: 123
        }

        get :show, params: request_params

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq('Conta com id 123 não existe')
      end
    end
  end
end
