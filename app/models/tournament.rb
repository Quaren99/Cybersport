class Tournament < ApplicationRecord
  include Searchable

  has_many :participants, dependent: :destroy
  has_many :teams, through: :participants

  validates :name, presence: true, uniqueness: true
  validates :prizepool, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
