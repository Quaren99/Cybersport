module Api
  module V1
    class PlayersController < APIController
      before_action :set_player, only: %i[show]

      # GET /players
      def index
        @players = Player.limit(@limit)

        render json: @players
      end

      # GET /players/1
      def show
        render json: @player, serializer: PlayerDetailedSerializer
      end

      def search
        @players = Player.search(
          params: params.expect(player: %i[query age]),
          exact_filters: [:age],
          text_fields: %i[nickname realname]
        ).limit(@limit).order(:nickname)

        if @players.empty?
          render json: { error: I18n.t(:player_not_found) }, status: :not_found
        else
          render json: @players
        end
      end

      private

      def set_player
        @player = Player.find(params.expect(:id))
      end
    end
  end
end
