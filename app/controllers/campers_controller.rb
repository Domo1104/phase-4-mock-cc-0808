class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid
    #GET /campers
    def index
        campers = Camper.all
        render json: campers
    end

    #GET /campers/:id
    def show
        camper = find_camper
        render json: camper, serializer: CamperActivitySerializer
    end

    #/POST /campers
    def create
        camper = Camper.create!(camper_params)
        render json: camper, only: [:id, :name, :age], status: :created
    end

    private
    def not_found
        render json: { error: "Camper not found" }, status: :not_found
    end

    def invalid(error)
        render json: { errors: error.record.errors.full_messages}, status: 422
    end

    def find_camper
        Camper.find_by(id: params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end
end
