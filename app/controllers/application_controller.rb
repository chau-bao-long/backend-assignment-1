class ApplicationController < ActionController::Base
  attr_accessor :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :show_error
  rescue_from StandardError, with: :show_uncaught_error
  rescue_from Api::Error, with: :api_error

  private

  def authenticate!
    @current_user = User.find_by id: session[:user_id]
    raise Api::Error, "unauthenticated" unless current_user
  end

  def show_errors exception
    render json: { error: exception.message }, status: :bad_request
  end

  def show_uncaught_error exception
    render json: { error: exception.message }, status: :internal_server_error
  end

  def api_error exception
    render json: { error: exception.message }, status: :bad_request
  end
end
