# app/controllers/reservations_controller.rb
class ReservationsController < ApplicationController
  before_action :set_time_slot, only: [:new, :create]

  def index
    @reservations = Current.user.reservations.includes(time_slot: :table).order('time_slots.start_time DESC')
  end

  def new
    @reservation = Current.user.reservations.new(time_slot_id: @time_slot.id)
  end

  def show
    @reservation = Current.user.reservations.find(params[:id])
  end

  def create
    @reservation = Current.user.reservations.new(reservation_params)

    # Check if slot is still available
    if @time_slot.reservation.present?
      redirect_to root_path, alert: 'Sorry, this time slot has already been booked.'
      return
    end

    if @reservation.save
      redirect_to @reservation, notice: 'Reservation was successfully created!'
    else
      @table = @time_slot.table
      render 'tables/show', status: :unprocessable_entity
    end
  end

  def update
    @reservation = Current.user.reservations.find(params[:id])

    if @reservation.update(reservation_params)
      redirect_to @reservation, notice: 'Reservation was successfully updated!'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Current.user.reservations.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: 'Reservation was cancelled.'
  end

  private

  def set_time_slot
    id = params[:time_slot_id] || params.dig(:reservation, :time_slot_id)
    @time_slot = TimeSlot.find(id)
  end

  def reservation_params
    params.require(:reservation).permit(:party_size, :contact_phone, :time_slot_id)
  end
end
