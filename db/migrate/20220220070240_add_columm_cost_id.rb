class AddColummCostId < ActiveRecord::Migration[5.2]
  def change
    add_column :incomes, :cost_id, :integer
    add_column :fixedcosts, :cost_id, :integer
    add_column :variablecosts, :cost_id, :integer
  end
end
