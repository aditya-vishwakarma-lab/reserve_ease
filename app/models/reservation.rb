class Reservation < ApplicationRecord
  validates :time_slot_id, uniqueness: true  # One booking per slot
  validates :party_size, presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: ->(r) { r.time_slot&.table&.capacity } }
  validates :contact_phone, presence: true
  belongs_to :user
  belongs_to :time_slot
end
