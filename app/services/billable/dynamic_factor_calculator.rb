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
    reckoner.parse word, resource
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
    "#{resource_class_sym}Parser".constantize
  end

end

class XmlParser
  def initialize(element)
    @element = element
  end

  def self.parse(element, resource)
    new(element).parse(resource)
  end

  def parse(resource)
    Nokogiri::XML(resource.body).search(@element).count
  end
end

class PageParser
  def initialize(word)
    @word = word
  end

  def self.parse(word, resource)
    new(word).parse(resource)
  end

  def parse(resource)
    resource.body.to_s.scan(/(?=#{@word})/).count
  end
end
