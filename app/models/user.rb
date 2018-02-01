class User < ApplicationRecord
  devise :database_authenticatable
  has_many :interests, dependent: :delete_all
  validates :email, uniqueness: true
end
