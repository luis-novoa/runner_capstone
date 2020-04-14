class Transaction < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  belongs_to :user
  belongs_to :group, optional: true
end
