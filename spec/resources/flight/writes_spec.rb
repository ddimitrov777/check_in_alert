require "rails_helper"

RSpec.describe FlightResource, type: :resource do
  describe "creating" do
    let(:payload) do
      {
        data: {
          type: "flights",
          attributes: {},
        },
      }
    end

    let(:instance) do
      FlightResource.build(payload)
    end

    it "works" do
      expect do
        expect(instance.save).to eq(true),
                                 instance.errors.full_messages.to_sentence
      end.to change { Flight.count }.by(1)
    end
  end

  describe "updating" do
    let!(:flight) { create(:flight) }

    let(:payload) do
      {
        data: {
          id: flight.id.to_s,
          type: "flights",
          attributes: {}, # Todo!
        },
      }
    end

    let(:instance) do
      FlightResource.find(payload)
    end

    xit "works (add some attributes and enable this spec)" do
      expect do
        expect(instance.update_attributes).to eq(true)
      end.to change { flight.reload.updated_at }
      # .and change { flight.foo }.to('bar') <- example
    end
  end

  describe "destroying" do
    let!(:flight) { create(:flight) }

    let(:instance) do
      FlightResource.find(id: flight.id)
    end

    it "works" do
      expect do
        expect(instance.destroy).to eq(true)
      end.to change { Flight.count }.by(-1)
    end
  end
end
