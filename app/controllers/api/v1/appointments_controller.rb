class Api::V1::AppointmentsController < ApplicationController
  before_action :set_current_user
  before_action :set_appointment, only: [:destroy]

  # GET /api/v1/appointments
  def index
    @appointments = @current_user.appointments.order(start_time: :asc)
    render json: @appointments
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
