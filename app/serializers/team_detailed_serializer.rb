class TeamDetailedSerializer < ActiveModel::Serializer
  attributes :name, :description, :worldRanking, :history, :sum_of_prizes
  has_many :members, scope: -> { where(left: nil) }
  has_many :tournaments

  def tournaments
    object.tournaments.order(date: :desc).map do |tournament|
      participant = tournament.participants.find_by(team_id: object.id)
      {
        id: tournament.id,
        name: tournament.name,
        date: tournament.date,
        won_prize: participant&.prize
      }
    end
  end

  def history
    history = object.members.map do |member|
      next unless member.left

      {
        player: member.player.nickname,
        joined: member.joined.strftime("%Y-%m-%d"),
        left: member.left.strftime("%Y-%m-%d")
      }
    end

    history.compact!

    history.sort_by { |h| h[:joined] }.reverse
  end
end
