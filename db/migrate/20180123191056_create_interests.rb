class CreateInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :interests do |t|
      t.string :name
      t.string :type
      t.belongs_to :user, index: true, foreign_key: true, null: false
    end
  end
end
