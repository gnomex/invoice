class Billable::Prestige < Billable::Base

  private

  def base_url
    'http://www.yourlocalguardian.co.uk/sport/rugby/rss/'
  end

  def dynamic_factor
    'pubDate'
  end
end
