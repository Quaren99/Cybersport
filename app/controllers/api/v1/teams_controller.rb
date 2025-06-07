module Api
  module V1
    class TeamsController < ApplicationController
      # GET /teams
      def index
        @teams = Team.limit(@limit)

        render json: @teams
      end

      # GET /teams/1
      def show
        set_team
        render json: @team, serializer: TeamDetailedSerializer
      end

      def search
        @teams = Team.search(
          params: params.expect(team: %i[query worldRanking]),
          exact_filters: [:worldRanking],
          text_fields: %i[name description]
        ).limit(@limit).order(:name)

        if @teams.empty?
          render json: { error: "No teams found" }, status: :not_found
        else
          render json: @teams
        end
      end

      private

      def set_team
        @team = Team.find(params.expect(:id))
      end
    end
  end
end
