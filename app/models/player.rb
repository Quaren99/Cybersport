class Player < ApplicationRecord
  include Searchable

  has_many :members, dependent: :destroy
  has_many :teams, through: :members

  validates :nickname, presence: true, uniqueness: true
  validates :realname, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id nickname realname age created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[members teams]
  end

  def won_tournaments_count
    teams_members = members.includes(:team)
    count = 0
    teams_members.each do |member|
      member.team.participants.each do |participant|
        count += 1 if participant.place == 1 && was_member?
      end
    end

    count
  end

  private

  def was_member?
    participant.tournament.date > member.joined && (member.left.nil? || participant.tournament.date < member.left)
  end
end
