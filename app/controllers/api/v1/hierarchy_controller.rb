class Api::V1::HierarchyController < ActionController::Base
  def create
    Relation.build_relationship create_params
  end

  def index
  end

  def staff
    Staff.all_superiors_of staff_params[:name]
  end

  private

  def staff_params
    params.require(:name).permit(:name)
  end

  def create_params
    params.require(:personnel).permit(:personnel)
  end
end
