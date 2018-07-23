require 'rails_helper'

RSpec.describe 'Vehicles API', type: :request do
 
  let!(:vehicles) { create_list(:vehicle, 10) }
  let(:vehicle_id) { vehicles.first.id }

 
  describe 'GET /vehicles' do
   
    before { get '/vehicles' }

    it 'returns vehicles' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

 
  describe 'GET /vehicles/:id' do
    before { get "/vehicles/#{vehicle_id}" }

    context 'when the record exists' do
      it 'returns the vehicle' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(vehicle_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:vehicle_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Vehicle/)
      end
    end
  end

  
  describe 'POST /vehicles' do
 
    let(:valid_attributes) { { licenceNum: 'AB 3435', vehicleType: 'car', vehicleModel: 'mazda 6', modelYear: '2015', odoRead: '5735578' } }

    context 'when the request is valid' do
      before { post '/vehicles', params: valid_attributes }

      it 'creates a vehicle' do
        expect(json['licenceNum']).to eq('AB 3435')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/vehicles', params: { licenceNum: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end



  end

  
  describe 'PUT /vehicles/:id' do
    let(:valid_attributes) { { licenceNum: 'BC 4545' } }

    context 'when the record exists' do
      before { put "/vehicles/#{vehicle_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  
  describe 'DELETE /vehicles/:id' do
    before { delete "/vehicles/#{vehicle_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end