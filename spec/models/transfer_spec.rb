require 'rails_helper'

describe Transfer, type: :model do
  describe 'validations' do
    let(:source_account) { create(:account) }
    let(:destination_account) { create(:account) }

    context 'when account id is valid' do
      it 'has a numerical value' do
        transfer = create(
          :transfer,
          source_account_id: source_account.id,
          destination_account_id: destination_account.id
        )
        expect(transfer).to be_valid
        expect(Transfer.last).to have_attributes(
          source_account_id: source_account.id,
          destination_account_id: destination_account.id
        )
      end
    end

    context 'when account id is not valid' do
      it 'does not have a value' do
        transfer = build(
          :transfer,
          source_account_id: nil,
          destination_account_id: destination_account.id
        )
        expect(transfer).not_to be_valid
      end

      it 'does not have a numerical value' do
        transfer = build(
          :transfer,
          source_account_id: 'two',
          destination_account_id: destination_account.id
        )
        expect(transfer).not_to be_valid
      end

      it 'does not belong to an existing account' do
        transfer = build(
          :transfer,
          source_account_id: 9988,
          destination_account_id: destination_account.id
        )
        expect(transfer).not_to be_valid
      end
    end

    context 'when amount is valid' do
      it 'has a positive numerical value' do
        transfer = create(
          :transfer,
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: 5000
        )
        expect(transfer).to be_valid
        expect(Transfer.last.amount).to eq(5000)
      end
    end

    context 'when amount is not valid' do
      it 'does not have a value' do
        transfer = build(
          :transfer,
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: nil
        )
        expect(transfer).not_to be_valid
      end

      it 'does not have a numerical value' do
        transfer = build(
          :transfer,
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: 'one thousand'
        )
        expect(transfer).not_to be_valid
      end

      it 'does not have a positive numerical value' do
        transfer = build(
          :transfer,
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: -5000
        )
        expect(transfer).not_to be_valid
      end
    end
  end
end
