class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    #GET /campers
    def index
        campers = Camper.all
        render json: campers, only: [:id, :name, :age]
    end

    #GET /campers/:id
    def show
        camper = find_camper
        render json: camper, only: [:id, :name, :age], include: [activities: {only: [:id, :name, :difficulty]}]
    end

    #/POST /campers
    def create
        camper = Camper.create(camper_params)
        render json: camper, only: [:id, :name, :age], status: :created
    end

    private
    def render_not_found_response
        render json: { error: "Camper not found" }, status: 404
    end

    def find_camper
        Camper.find_by(id: params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end
end
