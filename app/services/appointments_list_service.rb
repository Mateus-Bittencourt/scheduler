class AppointmentsListService
  Result = Struct.new(:success?, :data, :pagination, :error)

  def initialize(current_user, params = {})
    @current_user = current_user
    @params = params
  end

  def call
    base_scope = @current_user
      .appointments.includes(:professional, :user)
      .order(start_time: :asc)

    @pagy = Pagy.new(count: base_scope.count, page: @params[:page])

    @appointments = base_scope.offset(@pagy.offset).limit(@pagy.limit)

    mapped_data = map_appointments
    Result.new(true, mapped_data, @pagy, nil)
  rescue StandardError => e
    Rails.logger.error("\n\nError in AppointmentsListService: #{e.message}\n\n")

    Result.new(false, nil, nil, "An error occurred while listing appointments.")
  end

  private

  def map_appointments
    @appointments.map do |appointment|
      {
        id: appointment.id,
        appointment_date: I18n.l(appointment.start_time.to_date, format: :default, locale: :en),
        appointment_time: I18n.l(appointment.start_time, format: :time_only, locale: :en),
        professional: {
          name: appointment.professional.name,
          specialty: appointment.professional.specialty,
        },
        user: {
          name: appointment.user.name,
        },
      }
    end
  end
end
