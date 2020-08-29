require 'rails_helper'

RSpec.describe Billable::Flexible, type: :service do
  let(:base_price) { 1000 }
  let(:instance) { described_class.new(base_price) }

  describe '#calculate_invoice' do
    let(:expected_price) { base_price + 68 }

    subject { instance.calculate_invoice }

    it 'return how many words it found on site plus base_price' do
      expect(subject).to eq(expected_price)
    end

    it "the url MUST be" do
      expect(instance.send(:base_url)).to eq("http://reuters.com")
    end
  end

  describe '#margin' do
    let(:dynamic_calculator) { Billable::DynamicFactorCalculator.new('', '') }
    let(:total) { 200 }
    let(:expected_value) { total / 100 }

    subject { instance.send(:margin) }

    before do
      allow(Billable::DynamicFactorCalculator).to receive(:new).
        and_return(dynamic_calculator)
      allow(dynamic_calculator).to receive(:count).and_return(total)
    end

    it 'returns the word count divided by a hundred' do
      expect(subject).to eq(expected_value)
    end
  end
end
