class Api::V1::HierarchyController < ApplicationController
  before_action :authenticate!
  before_action :clean_hierarchy, only: :create

  def create
    Relation.refresh_hierarchy! create_params
  end

  def index
    render json: Relation.build_relationship
  end

  def staff
    render json: Staff.all_superiors_of(staff_params[:name])
  end

  private

  def staff_params
    params.permit(:name)
  end

  def create_params
    params.require(:personnel)
  end

  def clean_hierarchy
    Staff.destroy_all
    Relation.destroy_all
  end
end
