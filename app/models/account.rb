class Account < ApplicationRecord
  belongs_to :subscription

  validates :code, presence: true, uniqueness: true
end
