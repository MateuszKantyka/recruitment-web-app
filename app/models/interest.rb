class Interest < ApplicationRecord
  self.inheritance_column = nil
  belongs_to :user
  enum type: %I[health hobby work]
end
