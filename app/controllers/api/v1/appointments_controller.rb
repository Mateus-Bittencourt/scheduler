class Api::V1::AppointmentsController < ApplicationController
  before_action :set_current_user
  before_action :set_appointment, only: [:destroy]

  # GET /api/v1/appointments
  def index
    result = AppointmentsListService.new(@current_user, params).call

    if result.success?
      render json: {
        data: result.data,
        pagination: pagy_metadata(result.pagination),
      }, status: :ok
    else
      render json: { error: result.error }, status: :unprocessable_content
    end
  end

  # POST /api/v1/appointments
  def create
    @appointment = @current_user.appointments.new(appointments_params)

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: { errors: @appointment.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/appointments/:id
  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def appointments_params
    params.require(:appointment).permit(:professional_id, :start_time)
  end

  def set_appointment
    @appointment = @current_user.appointments.find(params[:id])
  end

  def set_current_user
    @current_user = User
      .first_or_create!(name: "Lorem User", email: "loremuser@gmail.com")
  end
end
