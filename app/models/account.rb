class Account < ApplicationRecord
  validates :name, presence: true
  validates :balance, presence: true, numericality: true
  validates :token, presence: true, uniqueness: { case_sensitive: true }
end
