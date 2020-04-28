class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all.map {|r| {id: r.id, created_at: r.created_at, lines: r.products_list, status: r.status}}
    @cursor = ""
    render json: {reservations: @reservations, cursor: @cursor}
  end

  def create
    line = []

    params.fetch(:lines).each do |product|
      @product = Product.find_by_product!(product.fetch('product'))
      @quantity = Integer(product.fetch('quantity'))
      raise RangeError if @quantity < 1
      Integer((product['quantity'])).times { line.append({product_id: @product.id})}
    end

    @reservation = Reservation.create(status: "PENDING", products_reservations_attributes: line)
    json_response({id: @reservation.id, created_at: @reservation.created_at, lines: params[:lines], status: @reservation.status}, :created)
  end
end
