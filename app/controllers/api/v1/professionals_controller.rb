class Api::V1::ProfessionalsController < ApplicationController

  # GET /api/v1/professionals
  def index
    result = ProfessionalsListService.new(params).call

    if result.success?
      render json: {
        data: ProfessionalSerializer.render_many(result.data),
        pagination: PaginationSerializer.render(result.pagination),
      }, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_content
    end
  end
end
