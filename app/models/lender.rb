class Lender < ActiveRecord::Base
  has_secure_password
  has_many :receipts
  has_many :money_lent, through: :receipts, source: :borrower

  validates :first_name,:last_name,:password, :money, presence: true, :on => :create
  validates :first_name,:last_name, length: { minimum: 2 }
  validates :money, numericality: { greater_than: 0 }
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
end
