class CreateCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :costs do |t|

      t.integer :income_id
      t.integer :fixedcost_id
      t.integer :variablecost_id
      t.integer :user_id
      t.integer :value
      t.datetime :start_time

      t.timestamps
    end
  end
end
