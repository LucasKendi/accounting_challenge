class Transfer < ApplicationRecord
  validates :source_account_id,
            :destination_account_id,
            :amount,
            presence: true, numericality: true
  validate :source_account_presence, :destination_account_presence

  private

  def source_account_presence
    return if Account.exists?(source_account_id)

    errors.add(:source_account_id, 'does not exists')
  end

  def destination_account_presence
    return if Account.exists?(destination_account_id)

    errors.add(:destination_account_id, 'does not exists')
  end
end
