module Api
    module V1
      class PlayersController < ApplicationController
        before_action :set_player, only: %i[ show]

        # GET /players
        def index
          @players = Player.all

          render json: @players
        end

        # GET /players/1
        def show
          render json: @player, serializer: PlayerDetailedSerializer
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_player
            @player = Player.find(params.expect(:id))
          end

          # Only allow a list of trusted parameters through.
          def player_params
            params.expect(player: [ :nickname, :realname, :age ])
          end
      end
    end
end
