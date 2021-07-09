require 'rails_helper'

RSpec.describe "flights#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/flights/#{flight.id}", params: params
  end

  describe 'basic fetch' do
    let!(:flight) { create(:flight) }

    it 'works' do
      expect(FlightResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('flights')
      expect(d.id).to eq(flight.id)
    end
  end
end
