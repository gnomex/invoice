require 'rails_helper'

RSpec.describe Billable::Fixed, type: :service do
  let(:base_price) { 1000 }
  let(:instance) { described_class.new(base_price) }

  describe '.calculate_invoice' do
    let(:expected_price) { base_price + 9 }

    subject { instance.calculate_invoice }

    it 'return how many words it found on site plus base_price' do
      expect(subject).to eq(expected_price)
    end

    it "the url MUST be" do
      expect(instance.send(:base_url)).to eq(
        "https://developer.github.com/v3/#http-redirects"
      )
    end
  end
end
