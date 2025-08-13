# app/models/time_slot.rb
class TimeSlot < ApplicationRecord
  belongs_to :table
  has_one :reservation, dependent: :destroy

  scope :available, -> { left_joins(:reservation).where(reservations: { id: nil }) }
  scope :future, -> { where('start_time >= ?', Time.current) }

  def duration_hours
    ((end_time - start_time) / 1.hour).round(1)
  end
end
