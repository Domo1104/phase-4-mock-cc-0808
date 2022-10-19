class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    #POST /signups
    def create
        signup = Signup.create!(signup_params)
        render json: signup, only: [:time, :camper_id, :activity_id], include: [activity: {only: [:id, :name, :difficulty]}], 
        status: :created
    end

    private

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def not_found
        render json: { error: "Validation errors" }, status: 500
    end
end
