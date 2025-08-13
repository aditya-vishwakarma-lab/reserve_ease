class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :reservations, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  enum :role, [:customer, :staff]

  STAFF_EMAILS = [
    'admin@restaurant.com',
    'manager@restaurant.com'
  ].freeze

  def self.staff_email?(email)
    STAFF_EMAILS.include?(email.downcase)
  end
end
