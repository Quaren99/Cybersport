class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :worldRanking

  has_many :members

  def members
    if instance_options[:date]
      date = instance_options[:date]
      members = object.members
      members_on_date = []
      members.each do |member|
        members_on_date.push(member) if member.joined < date && (member.left.nil? || member.left > date)
      end
      members_on_date
    else
      object.members.where(left: nil)
    end
  end
end
