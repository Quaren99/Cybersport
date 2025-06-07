class ParticipantSerializer < ActiveModel::Serializer
  attributes :name, :team_id

  def name
    object.team.name
  end

  def team_id
    object.team.id
  end
end
