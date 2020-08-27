plans = [
  {
    plan: :fixed,
    price: 10_000.00
  },
  {
    plan: :flexible,
    price: 20_000.00
  },
  {
    plan: :prestige,
    price: 30_000.00
  }
]

plans = plans.map do |plan|
  Subscription.create(plan)
end

accounts = [
  {
    code: 'c8b9194df4',
    subscription: plans.first
  },
  {
    code: '7deae09e38',
    subscription: plans.second
  },
  {
    code: 'd81e5f815f',
    subscription: plans.last
  }
]

accounts.each do |acc|
  Account.create(acc)
end
