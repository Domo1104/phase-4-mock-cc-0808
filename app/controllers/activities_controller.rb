class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    #GET /activities
    def index
        activities = Activity.all
        render json: activities, only: [:id, :name, :difficulty]
    end

    #DELETE /avtivities
    def destroy
        activities = find_activities
        activities.destroy
        head :no_content
    end

    private

    def find_activities
        Activity.find_by(id: params[:id])
    end

    def not_found
        render json: {error: "Activity not found"}, status: :not_found
    end
end
