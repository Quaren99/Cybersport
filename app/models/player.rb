class Player < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :teams, through: :members

  validates :nickname, presence: true, uniqueness: true
  validates :realname, presence: true

  def won_tournaments_count
    teams_members = self.members.includes(:team)
    count = 0
    teams_members.each do |member|
      member.team.participants.each do |participant|
        if participant.place == 1 && participant.tournament.date > member.joined && (member.left == nil || participant.tournament.date < member.left)
          count += 1
        end
      end
    end

    count
  end
end
