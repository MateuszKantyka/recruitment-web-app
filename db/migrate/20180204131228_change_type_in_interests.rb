class ChangeTypeInInterests < ActiveRecord::Migration[5.1]
  def change
    #change_column :interests, :type, :integer
    change_column :interests, :type, 'integer USING CAST(type AS integer)'
  end
end
