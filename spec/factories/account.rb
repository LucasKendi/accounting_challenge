FactoryBot.define do
  factory :account do
    name { 'Michael de Santa' }
    balance { 10_000_000 }
    token { SecureRandom.urlsafe_base64 }
  end
end
