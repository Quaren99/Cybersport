class Member < ApplicationRecord
  belongs_to :player
  belongs_to :team

  validates :joined, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id player_id team_id joined left created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[player team]
  end
end
