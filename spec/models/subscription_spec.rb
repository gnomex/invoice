require 'rails_helper'

RSpec.describe Subscription, type: :model do

  describe 'associations' do
    it{ is_expected.to have_many(:accounts) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :plan }
    it { is_expected.to validate_inclusion_of(:plan).in_array(['flexible', 'fixed', 'prestige']) }
    it { is_expected.to validate_presence_of :price }
  end

end
