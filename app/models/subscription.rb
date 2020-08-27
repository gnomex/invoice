class Subscription < ApplicationRecord
  has_many :accounts

  validates :plan, presence: true, inclusion: { in: %w(flexible fixed prestige) }, uniqueness: true
  validates :price, presence: true
  validates :frequency, presence: true
end
