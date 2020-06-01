require 'rails_helper'

describe Api::V1::TransfersController, type: :controller do
  describe 'POST #create' do
    let(:source_account) { create(:account, balance: 5000) }
    let(:destination_account ) { create(:account, balance: 5000) }
    context 'when the request is correct' do
      it 'returns htpp success and apply the transfer', :aggregate_failures do
        request_params = {
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: 2500
        }

        post :create, params: request_params

        expect(response).to have_http_status(:success)
        expect(Transfer.count).to eq(1)
        expect(Transfer.last).to have_attributes(
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: 2500
        )

        expect(source_account.reload.balance).to eq(2500)
        expect(destination_account.reload.balance).to eq(7500)
      end
    end

    context 'when the source account does not have enough funds' do
      it 'fails transaction and shows error message', :aggregate_failures do
        request_params = {
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: 10_000
        }

        post :create, params: request_params

        expect(response).to have_http_status(:not_acceptable)
        expect(JSON.parse(response.body)).to eq(['Source account has insufficient funds'])
        expect(Transfer.count).to be(0)
        expect(source_account.balance).to eq(5000)
        expect(destination_account.balance).to eq(5000)
      end
    end

    context 'when an account does not exists' do
      it 'warns when the source account does not exists', :aggregate_failures do
        request_params = {
          source_account_id: 555,
          destination_account_id: destination_account.id,
          amount: 10_000
        }

        post :create, params: request_params
        expect(response).to have_http_status(:not_acceptable)
        expect(JSON.parse(response.body)).to eq(['Source account does not exists'])
      end

      it 'warns when the destination account does not exists', :aggregate_failures do
        request_params = {
          source_account_id: source_account.id,
          destination_account_id: 555,
          amount: 5000
        }

        post :create, params: request_params
        expect(response).to have_http_status(:not_acceptable)
        expect(JSON.parse(response.body)).to eq(['Destination account does not exists'])
      end
    end
  end
end
