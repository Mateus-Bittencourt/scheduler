class PaginationSerializer
  def self.render(pagy)
    {
      current_page: pagy.page,
      total_items: pagy.count,
      total_pages: pagy.pages,
      page_size: pagy.limit,
    }
  end
end
