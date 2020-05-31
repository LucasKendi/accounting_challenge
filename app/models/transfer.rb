class Transfer < ApplicationRecord
  validates :source_account_id,
            :destination_account_id,
            :amount,
            presence: true, numericality: true
  validates :amount, numericality: { greater_than: 0 }
  validate :source_account_presence,
           :destination_account_presence,
           :source_account_has_enough_balance

  private

  def source_account_presence
    return if Account.exists?(source_account_id)

    errors.add(:source_account_id, 'does not exists')
  end

  def destination_account_presence
    return if Account.exists?(destination_account_id)

    errors.add(:destination_account_id, 'does not exists')
  end

  def source_account_has_enough_balance
    return unless Account.exists?(source_account_id)

    source_balance = Account.find(source_account_id).balance
    return if source_balance >= amount.to_i

    errors.add(:source_account_id, 'has insufficient funds')
  end
end
