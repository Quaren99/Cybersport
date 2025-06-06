class Member < ApplicationRecord
  belongs_to :player
  belongs_to :team

  validates :player, :joined, presence: true
end
