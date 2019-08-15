class Api::V1::HierarchyController < ApplicationController
  before_action :authenticate!

  def create
    RefreshHierarchy.perform! create_params
  end

  def index
    render json: BuildRelationship.perform!
  end

  def staff
    render json: GetAllSuperiors.perform!(staff_params)
  end

  private

  def staff_params
    params.permit(:name).require(:name)
  end

  def create_params
    params.require(:personnel)
  end
end
