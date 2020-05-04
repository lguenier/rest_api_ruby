require 'rails_helper'

RSpec.describe 'Inventory API', type: :request do
  # initialize test data
  let(:product) { create(:product, product: "PIPR-JACKET-SIZM", quantity: 200) }

  # Test suite for POST /reservations
  describe 'POST /reservations' do
    # valid payload
    let(:valid_attributes) { {"lines": [{"product": product.product, "quantity": 10}]} }

    context 'when the request is valid' do
      before { post '/reservations', params: valid_attributes }

      it 'created inventories' do
        expect(json.fetch("id"))
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request with badly formatted requeset' do
      before { post '/reservations', params: { product: product.product, quantity: 10 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when the request with wrong product' do
      before { post '/reservations', params: {"lines": [{"product": "toto", "quantity": 10}]}  }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the request with wrong quantity' do
      before { post '/reservations', params: {"lines": [{"product": product.product, "quantity": "toto"}]}  }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the request with key names' do
      before { post '/reservations', params: {"lines": [{"blabla": product.product, "quantity": "toto"}]}  }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when the request with key names' do
      before { post '/reservations', params: {"lines": [{"product": product.product, "blabla": "toto"}]}  }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end

  # # Test suite for GET /todos
  describe 'GET /orders' do
    let(:valid_attributes) { {"lines": [{"product": product.product, "quantity": 10}]} }

    before do
      post '/reservations', params: valid_attributes
      get '/orders'
    end

    it 'returns orders' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


end