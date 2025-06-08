module Api
  module V1
    class TournamentsController < ApiController
      before_action :set_tournament, only: %i[show]

      # GET /tournaments
      def index
        @tournaments = Tournament.limit(@@limit)

        render json: @tournaments
      end

      # GET /tournaments/1
      def show
        render json: @tournament, serializer: TournamentDetailedSerializer
      end

      def search
        @tournaments = Tournament.search(
          params: params.expect(tournament: %i[query date prizepool]),
          exact_filters: %i[prizepool date],
          text_fields: [:name]
        ).limit(@@limit).order(:name)

        if @tournaments.empty?
          render json: { error: I18n.t(:tournament_not_found) }, status: :not_found
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
        params.expect(tournament: %i[name date prizepool winner_id])
      end
    end
  end
end
