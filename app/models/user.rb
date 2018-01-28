class User < ApplicationRecord
  devise :database_authenticatable
  has_many :interests
  validates :email, uniqueness: true
end
