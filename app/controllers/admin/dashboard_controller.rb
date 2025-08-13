class Admin::DashboardController < Admin::BaseController
  def index
    @today_reservations = Reservation.joins(:time_slot)
                                  .where(time_slots: { start_time: Date.current.beginning_of_day..Date.current.end_of_day })
                                  .includes(:user, :time_slot => :table)
    @total_reservations = Reservation.count
    @active_time_slots = TimeSlot.count
  end
end
