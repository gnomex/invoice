require 'rails_helper'

RSpec.describe Billable::Base, type: :serice do
  let(:base_price) { 1000.0 }
  let(:instance) { described_class.new(base_price) }

  describe 'basic service api' do
    it { expect(described_class).to respond_to(:perform) }
    it { expect(instance).to respond_to(:calculate_invoice) }

    it 'privately respond to' do
      expected_private_methods = [:margin, :base_url, :dynamic_factor]

      expect(instance.private_methods(false)).to include(
        *expected_private_methods
      )
    end
  end

  describe '.perform' do
    subject { described_class.perform(base_price) }

    before do
      allow(described_class).to receive(:new).and_return(instance)
    end

    it 'creates a new instance and calls checkout' do
      expect(described_class).to receive(:new).with(base_price)
      expect(instance).to receive(:calculate_invoice)

      subject
    end
  end

  describe '#calculate_invoice' do
    let(:dynamic_value) { 1234 }
    let(:dynamic_factor_calculator) {
      Billable::DynamicFactorCalculator.new("", 'dynamic_factor')
    }

    subject { instance.calculate_invoice }

    before do
      allow(dynamic_factor_calculator).to receive(:count)
        .and_return(1234)
      allow(Billable::DynamicFactorCalculator).to receive(:new).
        and_return(dynamic_factor_calculator)
    end

    it 'calculates the invoice value' do
      expect(subject).to eq(base_price + dynamic_value)
    end
  end

end
