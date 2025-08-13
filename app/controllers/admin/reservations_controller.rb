class Admin::ReservationsController < Admin::BaseController
  before_action :set_time_slot, only: [:new, :create]
  before_action :set_reservation, only: [:show, :update, :destroy]

  def index
    @reservations = Reservation.includes(:user, time_slot: :table)
                              .order('time_slots.start_time DESC')
  end

  def new
    @reservation = @time_slot.reservations.new
  end

  def create
    @reservation = @time_slot.reservations.new(reservation_params)

    if @reservation.save
      redirect_to admin_reservations_path, notice: 'Reservation created.'
    else
      render :new
    end
  end

  def show
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path, notice: 'Reservation updated.'
    else
      render :show
    end
  end

  def destroy
    @reservation.destroy
    redirect_to admin_reservations_path, notice: 'Reservation cancelled.'
  end

  private

  def set_time_slot
    @time_slot = TimeSlot.find(params[:time_slot_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:party_size, :contact_phone)
  end
end
