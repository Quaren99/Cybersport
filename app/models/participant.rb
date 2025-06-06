class Participant < ApplicationRecord
  belongs_to :tournament
  belongs_to :team

  validates :place, presence: true, uniqueness: { scope: :tournament_id }, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :prize, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
