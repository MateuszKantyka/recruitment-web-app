class User < ApplicationRecord
  devise :database_authenticatable
  has_many :interests, dependent: :delete_all
  validates :email, uniqueness: true

  def self.to_csv
   attributes = %w{id email is_male birthday interests}

   CSV.generate(headers: true) do |csv|
     csv << attributes
     all.each do |user|
       csv << attributes.map{ |attr| user.send(attr) }
     end
   end
 end
end
