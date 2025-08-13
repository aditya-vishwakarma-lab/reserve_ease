# app/controllers/tables_controller.rb
class TablesController < ApplicationController
  def index
    @available_time_slots = TimeSlot.joins(:table)
                                    .left_joins(:reservation)
                                    .where(reservations: { id: nil })
                                    .where('start_time >= ?', Time.current)
                                    .includes(:table)
                                    .order(:start_time)
  end

  # def show
  #   @table = Table.find(params[:id])
  #   @time_slot = @table.time_slots.find(params[:time_slot_id])
  #   @reservation = Reservation.new(time_slot: @time_slot)
  # end
end
