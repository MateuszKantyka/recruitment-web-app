class User < ApplicationRecord
  devise :database_authenticatable

  validates :email, uniqueness: true
end
