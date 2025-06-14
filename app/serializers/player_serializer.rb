class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :realname, :age, :team

  def team
    name = object.members.where(left: nil).first&.team&.name
    return name if name.present?

    I18n.t(:free_agent)
  end
end
