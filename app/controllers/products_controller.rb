class ProductsController < ApplicationController
  def index
    limit = params[:limit]
    cursor = params[:cursor]
    if limit
      limit = Integer(params[:limit])
      products = Product.where('id > ?', cursor.to_i).limit(limit)
    else
      products = Product.where('id > ?', cursor.to_i)
    end
    p products

    @cursor = products.pluck(:id)[-1].to_s
    @products = products.map {|p| {id: p.id, product: p.product, quantity: p.quantity, available: (p.quantity - p.reserved)}}

    json_response({inventory: @products, cursor: @cursor})

  end

  def create
    @product = Product.find_or_initialize_by(product: products_params.fetch(:product))
    @quantity = Integer(params.fetch(:quantity))
    raise RangeError if @quantity < 1

    @product.quantity = @product.quantity + @quantity
    @product.save!

    json_response(params.slice(:product, :quantity), :created)
  end

  private
  def products_params
    params.permit(:product, :quantity)
  end
end
