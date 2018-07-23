require 'rails_helper'

RSpec.describe 'Maintenances API' do
  # Initialize the test data
  let!(:vehicle) { create(:vehicle) }
  let!(:maintenances) { create_list(:maintenance, 20, vehicle_id: vehicle.id) }
  let(:vehicle_id) { vehicle.id }
  let(:id) { maintenances.first.id }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /vehicles/:vehicle_id/maintenances' do
    before { get "/vehicles/#{vehicle_id}/maintenances" }

    context 'when vehicle exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all vehicle maintenances' do
        expect(json.size).to eq(20)
      end
    end

    context 'when vehicle does not exist' do
      let(:vehicle_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Vehicle/)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /vehicles/:vehicle_id/maintenances/:id' do
    before { get "/vehicles/#{vehicle_id}/maintenances/#{id}" }

    context 'when vehicle maintenance exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the maintenance' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when vehicle maintenance does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Maintenance/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items
  describe 'POST /vehicles/:vehicle_id/maintenances' do
    let(:valid_attributes) { { mainTask: 'Mozart', done: false } }

    context 'when request attributes are valid' do
      before { post "/vehicles/#{vehicle_id}/maintenances", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/vehicles/#{vehicle_id}/maintenances", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: MainTask can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe 'PUT /vehicles/:vehicle_id/maintenances/:id' do
    let(:valid_attributes) { { mainTask: 'Mozart' } }

    before { put "/vehicles/#{vehicle_id}/maintenances/#{id}", params: valid_attributes }

    context 'when maintenance exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the maintenance' do
        updated_maintenance = Maintenance.find(id)
        expect(updated_maintenance.mainTask).to match(/Mozart/)
      end
    end

    context 'when the maintenance does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Maintenance/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /vehicles/:id' do
    before { delete "/vehicles/#{vehicle_id}/maintenances/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end