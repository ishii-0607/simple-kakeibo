class AddCreateFixedcosts < ActiveRecord::Migration[5.2]
  def change
    add_column :fixedcosts, :start_time, :datetime
    add_column :fixedcosts, :value, :integer
    add_column :fixedcosts, :user_id, :integer
  end
end
