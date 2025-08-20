class ApplicationController < ActionController::API
  include Pagy::Backend
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: "Resource not found" }, status: :not_found
  end
end
