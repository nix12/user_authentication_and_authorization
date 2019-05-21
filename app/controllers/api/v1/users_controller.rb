module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json

      def show
        respond_with User.friendly.find(params[:id])
      end

      def update
        respond_with User.friendly.find(params[:id])
      end
    end
  end
end
