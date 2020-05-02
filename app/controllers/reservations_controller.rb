class ReservationsController < ApplicationController
  def index
    limit = params[:limit]
    cursor = params[:cursor]
    if limit
      limit = Integer(params[:limit])
      reservations = Reservation.where('id > ?', cursor.to_i).limit(limit)
    else
      reservations = Reservation.where('id > ?', cursor.to_i)
    end

    @reservations = reservations.map {|r| {id: r.id, created_at: r.created_at, lines: r.products_list, status: r.status}}

    json_response({reservations: @reservations, cursor: @reservations.pluck(:id)[-1].to_s})
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
