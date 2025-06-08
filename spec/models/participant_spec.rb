require "rails_helper"

RSpec.describe Participant, type: :model do
  let(:tournament) { Tournament.create!(name: "Test Tournament", prizepool: 1000) }
  let(:team) { Team.create!(name: "Test Team") }

  subject { Participant.new(tournament: tournament, team: team) }

  it { should belong_to(:tournament) }
  it { should belong_to(:team) }
  it {
    should validate_uniqueness_of(:place)
      .scoped_to(:tournament_id)
      .allow_nil
  }
end
