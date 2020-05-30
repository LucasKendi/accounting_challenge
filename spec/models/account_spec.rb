require 'rails_helper'

describe Account, type: :model do
  describe 'validations' do
    context 'when name is valid' do
      it 'has a value', :aggregate_failures do
        account = create(:account, name: 'Michael de Santa')

        expect(account).to be_valid
        expect(Account.last).to eq(account)
        expect(account.name).to eq('Michael de Santa')
      end
    end

    context 'when name is not valid' do
      it 'does not have a value' do
        account = build(:account, name: nil)

        expect(account).not_to be_valid
      end
    end

    context 'when balance is valid' do
      it 'has an numerical value', :aggregate_failures do
        account = create(:account, balance: 4000)

        expect(account).to be_valid
        expect(Account.last).to eq(account)
        expect(account.balance).to eq(4000)
      end
    end

    context 'when balance is not valid' do
      it 'does not have a value' do
        account = build(:account, balance: nil)

        expect(account).not_to be_valid
      end

      it 'does not have a numerical value' do
        account = build(:account, balance: 'four')

        expect(account).not_to be_valid
      end
    end
  end
end
