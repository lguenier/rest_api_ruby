require 'rails_helper'

RSpec.describe 'Inventory API', type: :request do
  # initialize test data
  let(:product) { create_list(:product, 6) }

  # Test that the products and inventory were created
  describe "Products got created" do
    it "Products were created" do
      expect(product.count).to eq(6)
    end
  end

  # Test suite for GET /todos
  describe 'GET /inventory' do
    # make HTTP get request before each example
    before { get '/inventory' }

    it 'returns inventories' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


  # Test suite for POST /inventory
  describe 'POST /inventory' do
    # valid payload
    let(:valid_attributes) { { product: product.pluck(:product).sample, quantity: (1..10).to_a.sample } }

    context 'when the request is valid' do
      before { post '/inventory', params: valid_attributes }

      it 'created inventories' do
        expect(product.pluck(:product)).to include(json['product'])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request with invalid product' do
      before { post '/inventory', params: { product: "toto", quantity: 10 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request with invalid quantity' do
      before { post '/inventory', params: { product: product.pluck(:product).sample, quantity: "numbers" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the request with invalid quantity' do
      before { post '/inventory', params: { product: product.pluck(:product).sample, quantity: -1 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(416)
      end
    end

    context 'when the request with no product key' do
      before { post '/inventory', params: { nothing: product.pluck(:product).sample, quantity: 10 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when the request with no quantity key' do
      before { post '/inventory', params: { product: product.pluck(:product).sample, numbers: 10 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end
    end
  end
end