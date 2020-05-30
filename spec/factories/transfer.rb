FactoryBot.define do
  factory :transfer do
    source_account_id { 123 }
    destination_account_id { 234 }
    amount { 5000 }
  end
end
