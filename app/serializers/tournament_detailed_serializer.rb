class TournamentDetailedSerializer < ActiveModel::Serializer
  attributes :name, :date, :prizepool
  attribute :participants do
    object.participants
          .order(:place)
          .map do |participant|
      ActiveModelSerializers::SerializableResource.new(
        participant.team,
        serializer: TeamSerializer,
        date: object.date
      ).as_json
                                                  .merge(
                                                    place: participant.place,
                                                    prize: participant.prize
                                                  )
    end
  end
end
