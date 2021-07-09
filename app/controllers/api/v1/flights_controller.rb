class Api::V1::FlightsController < Api::V1::GraphitiController
  def index
    flights = FlightResource.all(params)
    respond_with(flights)
  end

  def show
    flight = FlightResource.find(params)
    respond_with(flight)
  end

  def create
    flight = FlightResource.build(params)

    if flight.save
      render jsonapi: flight, status: :created
    else
      render jsonapi_errors: flight
    end
  end

  def update
    flight = FlightResource.find(params)

    if flight.update_attributes
      render jsonapi: flight
    else
      render jsonapi_errors: flight
    end
  end

  def destroy
    flight = FlightResource.find(params)

    if flight.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: flight
    end
  end
end
