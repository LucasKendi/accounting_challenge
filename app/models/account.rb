class Account < ApplicationRecord
  validates :name, presence: true
  validates :balance, presence: true, numericality: true
  validates :token, presence: true, uniqueness: { case_sensitive: true }

  include ActiveSupport::NumberHelper

  def summary
    "Saldo de #{format_balance} na conta"
  end

  private

  def format_balance
    number_to_currency(
      balance.to_f / 100,
      unit: 'R$',
      separator: ',',
      delimiter: '',
      precision: 2
    )
  end
end
