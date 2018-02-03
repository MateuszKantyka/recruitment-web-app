class User < ApplicationRecord
  include UsersHelper
  devise :database_authenticatable
  has_many :interests, dependent: :delete_all
  validates :email, uniqueness: true

  def self.to_csv
   attributes = %w{id email gender age interests_list}

   CSV.generate(headers: true) do |csv|
     csv << attributes
     all.each do |user|
       csv << attributes.map{ |attr| user.send(attr) }
     end
   end
 end

 def gender
   is_male ? 'male' : 'female'
 end

 def age
   user_age(self)
 end

 def interests_list
   self.interests.pluck(:name).join(', ')
 end
end
