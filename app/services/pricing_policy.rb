class PricingPolicy

  def self.perform(strategy, base_price)
    new.perform(strategy, base_price)
  end

  ##
  # Invoke the Pricing calculator by strategy pattern
  # :strategy: subscription plan
  # :base_price: subscription price
  def perform(strategy, base_price)
    "Billable::#{strategy.titleize}".constantize.perform(base_price)
  end
end
