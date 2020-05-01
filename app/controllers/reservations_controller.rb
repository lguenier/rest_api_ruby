class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all.map {|r| {id: r.id, created_at: r.created_at, lines: r.products_list, status: r.status}}
    @cursor = ""
    render json: {reservations: @reservations, cursor: @cursor}
  end

  def create
    lines = Hash.new(0)

    params.fetch(:lines).each do |product|
      product_id = Product.find_by_product!(product.fetch('product')).id
      quantity = Integer(product.fetch('quantity'))
      raise RangeError if quantity < 1
      lines[product_id] += quantity
    end

    products_reservations_attributes = lines.map {|p_id, quantity| {product_id: p_id, quantity: quantity}}

    @reservation = Reservation.create(status: "PENDING", products_reservations_attributes: products_reservations_attributes)
    json_response({id: @reservation.id, created_at: @reservation.created_at, lines: params[:lines], status: @reservation.status}, :created)
  end
end
