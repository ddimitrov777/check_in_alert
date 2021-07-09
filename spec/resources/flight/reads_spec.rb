require 'rails_helper'

RSpec.describe FlightResource, type: :resource do
  describe 'serialization' do
    let!(:flight) { create(:flight) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(flight.id)
      expect(data.jsonapi_type).to eq('flights')
    end
  end

  describe 'filtering' do
    let!(:flight1) { create(:flight) }
    let!(:flight2) { create(:flight) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: flight2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([flight2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:flight1) { create(:flight) }
      let!(:flight2) { create(:flight) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            flight1.id,
            flight2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            flight2.id,
            flight1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
