class Member < ApplicationRecord
  belongs_to :player
  belongs_to :team

  validates :joined, presence: true
end
