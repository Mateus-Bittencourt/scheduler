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

    Result.new(true, @appointments, @pagy, nil)
  rescue StandardError => e
    Rails.logger.error("\n\nError in AppointmentsListService:\n#{e.message}\n\n")
    Result.new(false, nil, nil, "An error occurred while listing appointments.")
  end
end
