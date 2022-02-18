class CreateVariablecosts < ActiveRecord::Migration[5.2]
  def change
    create_table :variablecosts do |t|

      t.string :name, null: false
      t.string :description
      t.date :year_month
      t.integer :value

      t.timestamps
    end
  end
end
