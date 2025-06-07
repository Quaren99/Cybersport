class MemberSerializer < ActiveModel::Serializer
  attributes :nickname, :player_id

  def nickname
    object.player.nickname
  end

  def player_id
    object.player.id
  end
end
