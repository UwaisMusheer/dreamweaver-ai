module Api
  module V1
    class DreamsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_dream, only: [ :show, :update, :destroy ]
      after_action :verify_authorized

      def index
        @dreams = policy_scope(Dream).order(dream_date: :desc)
        authorize Dream
        render json: @dreams
      end

      def show
        authorize @dream
        render json: @dream
      end

      def create
        @dream = current_user.dreams.build(dream_params)
        authorize @dream
        if @dream.save
          render json: @dream, status: :created
        else
          render json: @dream.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize @dream
        if @dream.update(dream_params)
          render json: @dream
        else
          render json: @dream.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @dream
        @dream.destroy
        head :no_content
      end

      private

      def set_dream
        @dream = Dream.find(params[:id]) # Note: We need global lookup here for authorization
      end

      def dream_params
        params.require(:dream).permit(:title, :description, :emotion, :dream_date, :tags)
      end
    end
  end
end
