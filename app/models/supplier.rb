class Supplier < ApplicationRecord
  # Validations
  validates :name, presence: true

  # Associations
  has_many :contracts
end

