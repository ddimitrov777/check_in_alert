class FlightsController < ApplicationController
  before_action :current_user_must_be_flight_user, only: [:edit, :update, :destroy] 

  before_action :set_flight, only: [:show, :edit, :update, :destroy]

  # GET /flights
  def index
    @q = current_user.flights.ransack(params[:q])
    @flights = @q.result(:distinct => true).includes(:user).page(params[:page]).per(10)
  end

  # GET /flights/1
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights
  def create
    @flight = Flight.new(flight_params)

    if @flight.save
      message = 'Flight was successfully created.'
      if Rails.application.routes.recognize_path(request.referrer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referrer, notice: message
      else
        redirect_to @flight, notice: message
      end
    else
      render :new
    end
  end

  # PATCH/PUT /flights/1
  def update
    if @flight.update(flight_params)
      redirect_to @flight, notice: 'Flight was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /flights/1
  def destroy
    @flight.destroy
    message = "Flight was successfully deleted."
    if Rails.application.routes.recognize_path(request.referrer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referrer, notice: message
    else
      redirect_to flights_url, notice: message
    end
  end


  private

  def current_user_must_be_flight_user
    set_flight
    unless current_user == @flight.user
      redirect_back fallback_location: root_path, alert: "You are not authorized for that."
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def flight_params
      params.require(:flight).permit(:user_id, :departs_at, :description, :alert_sent)
    end
end
