class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :not_found
    #POST /signups
    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, only: [:time, :camper_id, :activity_id], include: [activity: {only: [:id, :name, :difficulty]}], 
        status: :created
    end

    private

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def not_found(error)
        # byebug
        render json: { errors: error.record.errors.full_messages }, status: 422
    end
end
