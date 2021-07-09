class FlightsController < ApplicationController
  before_action :current_user_must_be_flight_user,
                only: %i[edit update destroy]

  before_action :set_flight, only: %i[show edit update destroy]

  def index
    @q = current_user.flights.ransack(params[:q])
    @flights = @q.result(distinct: true).includes(:user).page(params[:page]).per(10)
  end

  def show; end

  def new
    @flight = Flight.new
  end

  def edit; end

  def create
    @flight = Flight.new(flight_params)

    if @flight.save
      message = "Flight was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @flight, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @flight.update(flight_params)
      redirect_to @flight, notice: "Flight was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @flight.destroy
    message = "Flight was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to flights_url, notice: message
    end
  end

  private

  def current_user_must_be_flight_user
    set_flight
    unless current_user == @flight.user
      redirect_back fallback_location: root_path,
                    alert: "You are not authorized for that."
    end
  end

  def set_flight
    @flight = Flight.find(params[:id])
  end

  def flight_params
    params.require(:flight).permit(:user_id, :departs_at, :description,
                                   :alert_sent)
  end
end
