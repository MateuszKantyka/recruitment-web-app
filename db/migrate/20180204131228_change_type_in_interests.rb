class ChangeTypeInInterests < ActiveRecord::Migration[5.1]
  def change
    change_column :interests, :type, :integer
  end
end
