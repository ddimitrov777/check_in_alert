require 'rails_helper'

RSpec.describe "flights#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/flights/#{flight.id}", payload
  end

  describe 'basic update' do
    let!(:flight) { create(:flight) }

    let(:payload) do
      {
        data: {
          id: flight.id.to_s,
          type: 'flights',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(FlightResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { flight.reload.attributes }
    end
  end
end
