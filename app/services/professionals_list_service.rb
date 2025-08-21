class ProfessionalsListService
  Result = Struct.new(:success?, :data, :pagination, :error)

  def initialize(params = {})
    @params = params
  end

  def call
    
    base_scope = Professional.all()
    debugger
    @pagy = Pagy.new(count: base_scope.count, page: @params[:page])
    @professionals = base_scope.offset(@pagy.offset).limit(@pagy.limit)

    Result.new(true, @professionals, @pagy, nil)
  rescue StandardError => e
    Rails.logger.error("\n\nError in ProfessionalsListService:\n#{e.message}\n\n")
    Result.new(false, nil, nil, "An error occurred while listing professionals.")
  end
end
