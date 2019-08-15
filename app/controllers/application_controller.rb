class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :show_error
  rescue_from StandardError, with: :show_uncaught_error

  private

  def show_errors exception
    render json: { error: exception.message }, status: :bad_request
  end

  def show_uncaught_error exception
    render json: { error: exception.message }, status: :internal_server_error
  end
end
