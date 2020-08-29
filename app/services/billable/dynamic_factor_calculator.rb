class Billable::DynamicFactorCalculator

  ##
  # :url: full URI
  # :word: single character or string, that value will be used
  #   to search the word element occurrences at given url
  def initialize(url, word)
    @url = url
    @word = word
  end

  def count
    # wrap the method to ilustrate how to keep the internal API isolated
    reckoner
  end

  private

  attr_reader :url, :word

  def resource
    @resource ||= Mechanize.start do |m|
      m.get url
    end
  end

  def resource_class_sym
    resource.class.to_s.demodulize
  end

  def reckoner
    fns = {
      "XmlFile": lambda { Nokogiri::XML(resource.body).search(word).count },
      "Page": lambda { resource.body.to_s.scan(/(?=#{word})/).count }
    }.with_indifferent_access

    fns[resource_class_sym].call
  end

end
