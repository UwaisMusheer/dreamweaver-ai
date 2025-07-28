module Api
  module V1
    class DreamsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_dream, only: [ :show, :edit, :update, :destroy ]

      def index
        @dreams = current_user.dreams.order(dream_date: :desc)
        render json: @dreams
      end

      def show
        render json: @dream
      end

      def create
        @dream = current_user.dreams.build(dream_params)
        if @dream.save
          render json: @dream, status: :created
        else
          render json: @dream.errors, status: :unprocessable_entity
        end
      end

      def update
        if @dream.update(dream_params)
          render json: @dream
        else
          render json: @dream.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @dream.destroy
        head :no_content
      end

      private

      def set_dream
        @dream = current_user.dreams.find(params[:id])
      end

      def dream_params
        params.require(:dream).permit(:title, :description, :emotion, :dream_date, :tags)
      end
    end
  end
end
