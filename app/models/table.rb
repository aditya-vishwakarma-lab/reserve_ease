class Table < ApplicationRecord
  has_many :time_slots, dependent: :destroy
end
