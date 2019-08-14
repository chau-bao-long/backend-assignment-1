class Api::V1::HierarchyController < ActionController::Base
  def create
    Relation.build_relationship create_params
  end

  def index
  end

  def staff
    render json: Staff.all_superiors_of(staff_params[:name])
  end

  private

  def staff_params
    params.permit(:name)
  end

  def create_params
    params.permit(:personnel)
  end
end
