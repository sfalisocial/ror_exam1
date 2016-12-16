class Borrower < ActiveRecord::Base
  has_secure_password
  has_many :receipts
  has_many :money_raised, through: :receipts, source: :lender

  validates :first_name,:last_name,:password, :purpose, :description, :needed, presence: true, :on => :create
  validates :first_name,:last_name, length: { minimum: 2 }
  validates :purpose, :description, length: { minimum: 5 }
  validates :needed, numericality: { greater_than: 0 }
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
