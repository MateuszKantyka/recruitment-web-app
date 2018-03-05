class User < ApplicationRecord
  devise :database_authenticatable
  has_one_attached :avatar
  has_many :interests, inverse_of: :user, dependent: :delete_all
  accepts_nested_attributes_for :interests, reject_if: :all_blank, allow_destroy: true
  validates :email, uniqueness: true

  def self.to_csv
    attributes = %w[id email gender age interests_list]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each { |user| csv << attributes.map { |attr| user.public_send(attr) } }
    end
  end

  def gender
    is_male ? 'male' : 'female'
  end

  def age
    now = Date.current

    age = now.year - birthday.year

    age -= 1 if birthday.month > now.month
    age -= 1 if now.month == birthday.month && now.day >= birthday.day

    age
  end

  def interests_list
    interests.pluck(:name).join(', ')
  end
end
