class Team < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :participants, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :worldRanking, uniqueness: true
end
