FactoryBot.define do
  factory :account do
    code { SecureRandom.hex(5) }
    subscription
  end

  factory :subscription do
    plan { :fixed }
    price { 1_000.00 }
  end
end
