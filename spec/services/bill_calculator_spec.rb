require 'rails_helper'

RSpec.describe BillCalculator, type: :serice do

  describe '.checkout' do
    let(:account_id) { 1 }
    let(:instance) { described_class.new(account_id) }
    let(:account) { nil }

    subject { described_class.checkout(account_id) }

    before do
      allow(described_class).to receive(:new).and_return(instance)
    end

    it 'creates a new instance and calls checkout' do
      expect(described_class).to receive(:new).with(account_id)
      expect(instance).to receive(:checkout)

      subject
    end
  end

  describe 'a new instance' do
    let(:account_id) { 1 }
    let(:instance) { described_class.new(account_id) }

    subject { described_class.new(account_id) }

    before do
      allow(described_class).to receive(:new).and_return(instance)
    end

    it 'creates a new instance with an account ID' do
      expect(described_class).to receive(:new).with(account_id)

      subject
    end
  end

  describe '#checkout' do
    let(:account_id) { nil }
    let(:instance) { described_class.new(account_id) }

    context 'find the account subscription plan' do
      let(:account) { create(:account) }
      let(:account_id) { account.id }

      subject { instance.send(:subscription) }

      before do
        allow(instance).to receive(:account).and_return(account)
      end

      it 'returns the current subscription ' do
        subscription = subject

        expect(subscription).to_not be_nil
        expect(subscription).to have_attributes(
          plan: 'fixed',
          price: 1000.0.to_d
        )
      end
    end

    context 'make the checkout' do
      let(:subscription) { build(:subscription) }

      subject { instance.checkout }

      before do
        allow(instance).to receive(:subscription).and_return(subscription)
      end

      it 'invoking Pricing Policy calculator' do
        expect(PricingPolicy).to receive(:perform).
          with(subscription.plan, subscription.price)

        subject
      end
    end
  end
end
