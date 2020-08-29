require 'rails_helper'

RSpec.describe PricingPolicy, type: :service do

  describe '.perform' do
    let(:strategy) { 'fixed' }
    let(:base_price) { 1000.0 }
    let(:instance) { described_class.new }

    subject { described_class.perform(strategy, base_price) }

    before do
      allow(described_class).to receive(:new).and_return(instance)
    end

    it 'creates a new instance and calls checkout' do
      expect(described_class).to receive(:new)
      expect(instance).to receive(:perform).with(strategy, base_price)

      subject
    end
  end

  describe '#perform' do
    let(:strategy) { 'fixed' }
    let(:base_price) { 1000.0 }
    let(:instance) { described_class.new }

    context 'forward the call to strategy service class' do

      subject { instance.perform(strategy, base_price) }

      describe 'fixed plan' do
        it 'instantiate and perform' do
          expect(Billable::Fixed).to receive(:perform).with(base_price)

          subject
        end
      end

      describe 'flexible plan' do
        let(:strategy) { 'flexible' }

        it 'instantiate and perform' do
          expect(Billable::Flexible).to receive(:perform).with(base_price)

          subject
        end
      end

      describe 'prestige plan' do
        let(:strategy) { 'prestige' }

        it 'instantiate and perform' do
          expect(Billable::Prestige).to receive(:perform).with(base_price)

          subject
        end
      end
    end
  end
end
