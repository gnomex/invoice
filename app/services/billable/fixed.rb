class Billable::Fixed < Billable::Base

  private

  def base_url
    'https://developer.github.com/v3/#http-redirects'
  end

  def dynamic_factor
    'status'
  end
end
