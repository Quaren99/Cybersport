class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :realname, :age, :team

  def team
    name = object.members.where(left: nil).first&.team&.name
    return name unless name.blank?

    "Free Agent"
  end
end
