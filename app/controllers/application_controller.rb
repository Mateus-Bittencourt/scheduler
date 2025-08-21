class ApplicationController < ActionController::API
  include Pagy::Backend

  rescue_from StandardError do |exception|
    Rails.logger.error("\n\nUNEXPECTED ERROR:\n#{exception.message}")
    Rails.logger.error("\n\n#{exception.backtrace.join("\n")}\n\n")

    render json: { error: "An unexpected internal server error occurred." },
           status: :internal_server_error
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: "Resource not found" },
           status: :not_found
  end
end
