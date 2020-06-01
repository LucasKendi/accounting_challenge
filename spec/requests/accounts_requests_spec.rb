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
    context 'when the request is correct with token' do
      it 'returns http success and account balance', :aggregate_failures do
        account = create(:account, id: 123, balance: 10_000)

        authorization = ActionController::HttpAuthentication::Token.encode_credentials(account.token)
        headers = { Authorization: authorization }
        request.headers.merge! headers

        request_params = { id: 123 }

        get :show, params: request_params

        expect(response).to have_http_status(:success)
        expect(response.body).to eq('Saldo de R$100,00 na conta')
      end
    end

    context 'when the account does not exist' do
      it 'returns unauthorized status', :aggregate_failures do
        request_params = { id: 123 }

        get :show, params: request_params

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to match('HTTP Token: Access denied.')
      end
    end
  end
end
