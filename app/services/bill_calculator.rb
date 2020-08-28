class BillCalculator

  def initialize(account_id)
    @account_id = account_id
  end

  def self.checkout(account_id)
    new(account_id).checkout
  end

  def checkout
    # get account
    # get subscription
    # call dynamic plan strategy to get variable data
    # apply calculation
    # return the bill
    PricingPolicy.perform subscription.plan, subscription.price
  end

  private

  def account
    @account ||= Account.find_by(id: @account_id)
  end

  def subscription
    account.subscription
  end
end
