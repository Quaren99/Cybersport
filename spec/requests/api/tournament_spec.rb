require "swagger_helper"

RSpec.describe "Tournaments API", swagger_doc: "v1/swagger.yaml", type: :request do # rubocop:disable Metrics/BlockLength
  let!(:tournament1) { Tournament.create!(name: "Major 2024", date: Time.zone.today, prizepool: 10_000) }
  let!(:tournament2) { Tournament.create!(name: "Minor 2024", date: Time.zone.today, prizepool: 5000) }

  path "/api/v1/tournaments" do
    get "Retrieves all tournaments" do
      tags "Tournaments"
      produces "application/json"

      response "200", "tournaments found" do
        run_test! do
          expect(response.parsed_body.size).to be >= 2
        end
      end
    end
  end

  path "/api/v1/tournaments/{id}" do
    get "Retrieves a tournament" do
      tags "Tournaments"
      produces "application/json"
      parameter name: :id, in: :path, type: :string

      response "200", "tournament found" do
        let(:id) { tournament1.id }
        run_test! do
          expect(response.parsed_body["name"]).to eq("Major 2024")
        end
      end

      response "404", "tournament not found" do
        let(:id) { "999999" }
        run_test!
      end
    end
  end

  path "/api/v1/tournaments/search" do
    get "Search tournaments" do
      tags "Tournaments"
      produces "application/json"
      parameter name: :"tournament[query]", in: :query, type: :string, required: true

      response "200", "tournaments found" do
        let(:"tournament[query]") { "Major" }
        run_test! do
          expect(response.parsed_body.first["name"]).to eq("Major 2024")
        end
      end

      response "404", "no tournaments found" do
        let(:"tournament[query]") { "Nonexistent" }
        run_test! do
          expect(response.parsed_body["error"]).to be_present
        end
      end
    end
  end
end
