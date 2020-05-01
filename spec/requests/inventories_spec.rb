require 'rails_helper'

RSpec.describe 'Inventory API', type: :request do
  # Test suite for POST /inventory
  describe 'POST /inventory' do
    # valid payload
    let(:valid_attributes) { { product: "PIPR-JACKET-SIZM", quantity: 200 } }

    context 'when the request is valid' do
      before { post '/inventory', params: valid_attributes }

      it 'created products' do
        expect(json['quantity']).to eq("200")
        expect(json['product']).to eq("PIPR-JACKET-SIZM")
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request with invalid product' do
      before { post '/inventory', params: { product: "toto", quantity: 10 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the request with invalid quantity' do
      before { post '/inventory', params: { product: "PIPR-JACKET-SIZM", quantity: "numbers" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the request with invalid quantity' do
      before { post '/inventory', params: { product: "PIPR-JACKET-SIZM", quantity: -1 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(416)
      end
    end

    context 'when the request with no product key' do
      before { post '/inventory', params: { nothing: "PIPR-JACKET-SIZM", quantity: 10 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end
    end

    context 'when the request with no quantity key' do
      before { post '/inventory', params: { product: "PIPR-JACKET-SIZM", numbers: 10 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end
    end
  end

  # Test suite for GET /inventory
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



end