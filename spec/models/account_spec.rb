require 'rails_helper'

RSpec.describe Account, type: :model do

  describe 'associations' do
    it{ is_expected.to belong_to(:subscription) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :code }
  end
end
