module Api
  module V1
    class TransfersController < ApplicationController
      before_action :authenticate

      def create
        transfer = Transfer.new(transfer_params)
        if transfer.valid?
          begin
            transfer.save!
            apply_exchange(transfer)
          rescue ActiveRecord::RecordInvalid => e
            render json: e
          end
        else
          render json: transfer.errors.full_messages, status: :not_acceptable
        end
      end

      private

      def transfer_params
        params.permit(:source_account_id, :destination_account_id, :amount)
      end

      def apply_exchange(transfer)
        source_account = Account.find(transfer.source_account_id)
        destination_account = Account.find(transfer.destination_account_id)
        Account.transaction do
          source_account.balance -= transfer.amount
          destination_account.balance += transfer.amount

          source_account.save!
          destination_account.save!
        end
      end
    end
  end
end
