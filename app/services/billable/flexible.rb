class Billable::Flexible < Billable::Base

  private

  def base_url
    'http://reuters.com'
  end

  def dynamic_factor
    'a'
  end

  def margin
    Billable::DynamicFactorCalculator.new(base_url, dynamic_factor).count / 100
  end
end
