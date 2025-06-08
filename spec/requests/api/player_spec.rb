require "swagger_helper"

RSpec.describe "Players API", swagger_doc: "v1/swagger.yaml", type: :request do # rubocop:disable Metrics/BlockLength
  let!(:player1) { Player.create!(nickname: "player_one", realname: "Alice", age: 20) }
  let!(:player2) { Player.create!(nickname: "player_two", realname: "Bob", age: 25) }

  path "/api/v1/players" do
    get "Retrieves all players" do
      tags "Players"
      produces "application/json"

      response "200", "players found" do
        run_test! do
          expect(response.parsed_body.size).to be >= 2
        end
      end
    end
  end

  path "/api/v1/players/{id}" do
    get "Retrieves a player" do
      tags "Players"
      produces "application/json"
      parameter name: :id, in: :path, type: :string

      response "200", "player found" do
        let(:id) { player1.id }
        run_test! do
          expect(response.parsed_body["nickname"]).to eq("player_one")
        end
      end

      response "404", "player not found" do
        let(:id) { "999999" }
        run_test!
      end
    end
  end

  path "/api/v1/players/search" do
    get "Search players" do
      tags "Players"
      produces "application/json"
      parameter name: :"player[query]", in: :query, type: :string, required: false
      parameter name: :"player[age]", in: :query, type: :integer, required: false

      response "200", "players found" do
        let(:"player[query]") { "player_one" }
        let(:"player[age]") { 20 }
        run_test! do
          expect(response.parsed_body.first["nickname"]).to eq("player_one")
        end
      end

      response "404", "no players found" do
        let(:"player[query]") { "nonexistent" }
        let(:"player[age]") { 99 }
        run_test! do
          expect(response.parsed_body["error"]).to be_present
        end
      end
    end
  end
end
