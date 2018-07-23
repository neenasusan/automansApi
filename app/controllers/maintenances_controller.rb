class MaintenancesController < ApplicationController
  before_action :set_vehicle
  before_action :set_vehicle_maintenance, only: [:show, :update, :destroy]

  # GET /todos/:todo_id/items
  def index
    json_response(@vehicle.maintenances)
  end

  # GET /todos/:todo_id/items/:id
  def show
    json_response(@maintenance)
  end

  # POST /todos/:todo_id/items
  def create
    @vehicle.maintenances.create!(maintenance_params)
    json_response(@vehicle, :created)
  end

  # PUT /todos/:todo_id/items/:id
  def update
    @maintenance.update(maintenance_params)
    head :no_content
  end

  # DELETE /todos/:todo_id/items/:id
  def destroy
    @maintenance.destroy
    head :no_content
  end

  private

  def maintenance_params
    params.permit(:mainTask, :done)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def set_vehicle_maintenance
    @maintenance = @vehicle.maintenances.find_by!(id: params[:id]) if @vehicle
  end
end
