class Interest < ApplicationRecord
  self.inheritance_column = nil
  belongs_to :user
end
