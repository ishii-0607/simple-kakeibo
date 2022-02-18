class AddCreateFixedcosts < ActiveRecord::Migration[5.2]
  def change
    add_column :fixedcosts, :year_month, :date
    add_column :fixedcosts, :value, :integer
  end
end
