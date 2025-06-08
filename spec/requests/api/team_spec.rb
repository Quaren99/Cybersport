require "swagger_helper"

RSpec.describe "Teams API", swagger_doc: "v1/swagger.yaml", type: :request do # rubocop:disable Metrics/BlockLength
  let!(:team1) { Team.create!(name: "Team Alpha", worldRanking: 1) }
  let!(:team2) { Team.create!(name: "Team Beta", worldRanking: 2) }

  path "/api/v1/teams" do
    get "Retrieves all teams" do
      tags "Teams"
      produces "application/json"

      response "200", "teams found" do
        run_test! do
          expect(response.parsed_body.size).to be >= 2
        end
      end
    end
  end

  path "/api/v1/teams/{id}" do
    get "Retrieves a team" do
      tags "Teams"
      produces "application/json"
      parameter name: :id, in: :path, type: :string

      response "200", "team found" do
        let(:id) { team1.id }
        run_test! do
          expect(response.parsed_body["name"]).to eq("Team Alpha")
        end
      end

      response "404", "team not found" do
        let(:id) { "999999" }
        run_test!
      end
    end
  end

  path "/api/v1/teams/search" do
    get "Search teams" do
      tags "Teams"
      produces "application/json"
      parameter name: :"team[query]", in: :query, type: :string, required: false
      parameter name: :"team[worldRanking]", in: :query, type: :integer, required: false

      response "200", "teams found" do
        let(:"team[query]") { "Alpha" }
        let(:"team[worldRanking]") { 1 }
        run_test! do
          expect(response.parsed_body.first["name"]).to eq("Team Alpha")
        end
      end

      response "404", "no teams found" do
        let(:"team[query]") { "Nonexistent" }
        let(:"team[worldRanking]") { 999 }
        run_test! do
          expect(response.parsed_body["error"]).to be_present
        end
      end
    end
  end
end
