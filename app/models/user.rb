class User < ActiveRecord::Base
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :email, uniqueness: true
  validates :password, confirmation: true, length: { minimum: 6 }
  has_many :decks, dependent: :destroy
end
