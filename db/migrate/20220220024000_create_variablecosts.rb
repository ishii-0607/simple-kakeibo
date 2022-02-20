class CreateVariablecosts < ActiveRecord::Migration[5.2]
  def change
    create_table :variablecosts do |t|

      t.string :name, null: false
      t.string :description
      t.integer :value
      t.integer :user_id
      t.datetime :start_time

      t.timestamps
    end
  end
end
