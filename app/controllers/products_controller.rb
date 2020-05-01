class ProductsController < ApplicationController
  def index
    if params[:limit] and params[:limit].to_i < 1
      Integer(params.fetch(:limit))
    else
      @products = Product.all.map {|p| {product: p.product, quantity: p.quantity, available: (p.quantity - p.reserved)}}
      @cursor = ""
      json_response({inventory: @products, cursor: ""})
    end
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
