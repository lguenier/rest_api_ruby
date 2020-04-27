class InventoriesController < ApplicationController

  def index
    if params[:limit] and params[:limit].to_i < 1
      render json: {"error": "Limit parameter is not a positive integer, please provide a valid integer"}, status: 400
    else
      @products = Product.list_inventory params[:limit], params[:cursor]
      @cursor = ""
      json_response({inventory: @products, cursor: ""})
    end
  end

  def create
    @product = Product.find_by_product!(params.fetch(:product))
    @quantity = Integer(params.fetch(:quantity))
    raise RangeError if @quantity < 1
    Inventory.insert_all(@quantity.times.map {{product_id: @product.id}})
    json_response(params.slice(:product, :quantity), :created)
  end

  private
  def product_params
    params.permit(:product)
  end
end
