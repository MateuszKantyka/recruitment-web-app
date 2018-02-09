class User < ApplicationRecord
  devise :database_authenticatable
  has_many :interests, inverse_of: :user, dependent: :delete_all
  accepts_nested_attributes_for :interests, reject_if: :all_blank, allow_destroy: true
  validates :email, uniqueness: true
end
