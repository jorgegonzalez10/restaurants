class ProductService
  def initialize(params)
    @params = params
  end

  def call
    categories = Category.order(name: :asc)
    selected_category = Category.find_by(id: @params[:category_id]) if @params[:category_id].present?

    products = if @params[:query].present?
                 Product.search_products_by_name_price_or_discount(@params[:query])
               else
                 Product.all
               end

    products = products.where(category_id: @params[:category_id]) if @params[:category_id].present?
    products = products.where("price >= ?", @params[:min_price]) if @params[:min_price].present?
    products = products.where("price <= ?", @params[:max_price]) if @params[:max_price].present?

    {
      products: products,
      categories: categories,
      selected_category: selected_category
    }
  end
end
