module Api
  module V1
    class AccountsController < ApplicationController
      def create
        account = Account.new(account_params)
        account.token = SecureRandom.urlsafe_base64
        begin
          account.save!
          render json: { id: account.id, token: account.token }
        rescue ActiveRecord::RecordNotUnique
          render json: "O id #{account.id} já está sendo utilizado", status: :conflict
        end
      end

      def show
        account = Account.find_by(id: account_params[:id])
        if account.present?
          render json: "Saldo de #{account.balance} na conta"
        else
          render json: "Conta com id #{account_params[:id]} não existe", status: :not_found
        end
      end

      private

      def account_params
        params.permit(:id, :name, :balance)
      end
    end
  end
end
