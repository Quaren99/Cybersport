class PlayerDetailedSerializer < ActiveModel::Serializer
  attributes :nickname, :realname, :age, :team_name, :won_tournaments_count, :history

  def team_name
    name = object.members.where(left: nil).first&.team&.name
    return name if name.present?

    I18n.t(:free_agent)
  end

  def history
    history = object.members.map do |member|
      {
        team: member.team.name,
        joined: member.joined.strftime("%Y-%m-%d"),
        left: member.left&.strftime("%Y-%m-%d")
      }
    end

    history.sort_by { |h| h[:joined] }.reverse
  end
end
