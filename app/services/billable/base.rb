class Billable::Base

  def initialize(base_price)
    @base_price = base_price
  end

  def self.perform(base_price)
    new(base_price).calculate_invoice
  end

  def calculate_invoice
    base_price + margin
  end

  private

  attr_reader :base_price

  ##
  # Both base_url and dynamic_factor SHOULD be implemented in subclasses
  #
  def base_url; end

  def dynamic_factor; end

  def margin
    Billable::DynamicFactorCalculator.new(base_url, dynamic_factor).count
  end
end
