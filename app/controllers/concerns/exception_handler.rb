module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActionController::BadRequest do |e|
      json_response({ message: e.message }, :bad_request)
    end

    rescue_from KeyError do |e|
      json_response({ message: e.message }, :bad_request)
    end

    rescue_from RangeError do |e|
      json_response({message: e.message}, 416)
    end

    rescue_from ArgumentError do |e|
      json_response({message: e.message}, :unprocessable_entity)
    end
  end
end