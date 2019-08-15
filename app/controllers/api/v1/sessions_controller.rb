class Api::V1::SessionsController < ApplicationController
  def create
    user = User.authenticate!(
      name: create_params["name"], 
      password: create_params["password"], 
    )
    session[:user_id] = user.id
  end

  private

  def create_params
    params.permit(:name, :password)
  end
end
