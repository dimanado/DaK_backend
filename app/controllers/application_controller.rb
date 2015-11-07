class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  protect_from_forgery with: :null_session

  rescue_from ActionController::ParameterMissing, with: :invalid_params
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def render_error_messages(object, status = :unprocessable_entity)
    render json: { errors: object.errors.messages, fields: object.errors.keys },
           status: status, head: status
  end

  def render_success
    render json: { success: true }, status: :ok
  end

  def invalid_params(exception)
    render json: { errors: "Required parameter is missing: #{exception.param}" }, status: :unprocessable_entity, head: :unprocessable_entity
  end

  def not_found
    render json: { errors: "Item not found" }, status: :not_found, head: :not_found
  end

  def not_authorized
    render json: { errors: "Not allowed" }, status: 403, head: 403
  end
end
