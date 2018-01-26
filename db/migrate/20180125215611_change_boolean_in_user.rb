class ChangeBooleanInUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :admin, :boolean, null: false
    change_column :users, :is_male, :boolean, null: false
  end
end
