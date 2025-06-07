module Api
    module V1
      class TournamentsController < ApplicationController
        before_action :set_tournament, only: %i[ show]

        # GET /tournaments
        def index
          @tournaments = Tournament.all.limit(@@limit)

          render json: @tournaments
        end

        # GET /tournaments/1
        def show
          render json: @tournament, serializer: TournamentDetailedSerializer
        end

        def search
          @tournaments = Tournament.search(
            params: params.expect(tournament: [ :query, :date, :prizepool ]),
            exact_filters: [ :prizepool, :date ],
            text_fields: [ :name ]
          ).limit(@@limit).order(:name)

          if @tournaments.empty?
            render json: { error: "No tournaments found" }, status: :not_found
          else
            render json: @tournaments
          end
        end

        private
          def set_tournament
            @tournament = Tournament.find(params.expect(:id))
          end

          # Only allow a list of trusted parameters through.
          def tournament_params
            params.expect(tournament: [ :name, :date, :prizepool, :winner_id ])
          end
      end
    end
end
