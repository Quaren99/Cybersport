class Tournament < ApplicationRecord
  include Searchable

  has_many :participants, dependent: :destroy
  has_many :teams, through: :participants

  validates :name, presence: true, uniqueness: true
  validates :prizepool, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name date prizepool created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[participants teams]
  end
end
