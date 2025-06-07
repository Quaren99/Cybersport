class Participant < ApplicationRecord
  belongs_to :tournament
  belongs_to :team

  validates :place, uniqueness: { scope: :tournament_id }, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :prize, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
end
