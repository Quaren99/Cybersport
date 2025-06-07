class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :prizepool
  has_many :participants
end
