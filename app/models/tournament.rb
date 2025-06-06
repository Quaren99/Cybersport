class Tournament < ApplicationRecord
  has_many :participants, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :prizepool, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
