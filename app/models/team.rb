class Team < ApplicationRecord
  include Searchable

  has_many :members, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :players, through: :members
  has_many :tournaments, through: :participants

  validates :name, presence: true, uniqueness: true
  validates :worldRanking, uniqueness: true, allow_nil: true

  def sum_of_prizes
    total_prize = 0
    participants.each do |participant|
      total_prize += participant.prize
    end
    total_prize
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name worldRanking description created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[members participants players tournaments]
  end
end
