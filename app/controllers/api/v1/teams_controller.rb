module Api
    module V1
      class TeamsController < ApplicationController
        before_action :set_team, only: %i[ show]

        # GET /teams
        def index
          @teams = Team.all

          render json: @teams
        end

        # GET /teams/1
        def show
          render json: @team
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_team
            @team = Team.find(params.expect(:id))
          end

          # Only allow a list of trusted parameters through.
          def team_params
            params.expect(team: [ :name, :worldRanking ])
          end
      end
    end
end
