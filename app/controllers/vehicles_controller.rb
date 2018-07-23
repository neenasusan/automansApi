class VehiclesController < ApplicationController

  before_action :set_vehicle, only: [:show, :update, :destroy]

  
  def index
    @vehicles = Vehicle.all
    json_response(@vehicles)
  end

  
  def create
    @vehicle = Vehicle.create!(vehicle_params)
    json_response(@vehicle, :created)
  end

  
  def show
    json_response(@vehicle)
  end

  
  def update
    @vehicle.update(vehicle_params)
    head :no_content
  end

  
  def destroy
    @vehicle.destroy
    head :no_content
  end

  private

  def vehicle_params
    params.permit(:licenceNum, :vehicleType, :vehicleModel, :modelYear, :odoRead)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

end
