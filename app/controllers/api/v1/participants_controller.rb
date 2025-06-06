module Api
  module V1
    class ParticipantsController < ApplicationController
      before_action :set_participant, only: %i[ show update destroy ]

      # GET /participants
      def index
        @participants = Participant.all

        render json: @participants
      end

      # GET /participants/1
      def show
        render json: @participant
      end

      # POST /participants
      def create
        @participant = Participant.new(participant_params)

        if @participant.save
          render json: @participant, status: :created, location: @participant
        else
          render json: @participant.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /participants/1
      def update
        if @participant.update(participant_params)
          render json: @participant
        else
          render json: @participant.errors, status: :unprocessable_entity
        end
      end

      # DELETE /participants/1
      def destroy
        @participant.destroy!
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_participant
          @participant = Participant.find(params.expect(:id))
        end

        # Only allow a list of trusted parameters through.
        def participant_params
          params.expect(participant: [ :tournament_id, :team_id, :place, :prize ])
        end
    end
  end
end
