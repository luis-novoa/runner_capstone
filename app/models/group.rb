class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 50 }
  validates :icon,
            presence: true,
            inclusion: { in: %w[walking biking horse motorcycle car-side subway ship plane space-shuttle] }
  belongs_to :user
  has_many :transactions
end
