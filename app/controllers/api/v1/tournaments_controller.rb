module Api
    module V1
      class TournamentsController < ApplicationController
        before_action :set_tournament, only: %i[ show]

        # GET /tournaments
        def index
          @tournaments = Tournament.all

          render json: @tournaments
        end

        # GET /tournaments/1
        def show
          render json: @tournament
        end

        private
          # Use callbacks to share common setup or constraints between actions.
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
