module Api
    module V1
      class PlayersController < ApplicationController
        before_action :set_player, only: %i[ show]

        # GET /players
        def index
          @players = Player.all.limit(@@limit)

          render json: @players
        end

        # GET /players/1
        def show
          render json: @player, serializer: PlayerDetailedSerializer
        end

        def search
          @players = Player.search(
            params: params.expect(player: [ :query, :age ]),
            exact_filters: [ :age ],
            text_fields: [ :nickname, :realname ]
          ).limit(@@limit).order(:nickname)

          if @players.empty?
            render json: { error: "No players found" }, status: :not_found
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
