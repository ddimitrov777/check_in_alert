require "rails_helper"

RSpec.describe "flights#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/flights", params: params
  end

  describe "basic fetch" do
    let!(:flight1) { create(:flight) }
    let!(:flight2) { create(:flight) }

    it "works" do
      expect(FlightResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(["flights"])
      expect(d.map(&:id)).to match_array([flight1.id, flight2.id])
    end
  end
end
