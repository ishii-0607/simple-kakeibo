class AddCreateIncomes < ActiveRecord::Migration[5.2]
  def change
    add_column :incomes, :start_time, :datetime
    add_column :incomes, :value, :integer
    add_column :incomes, :user_id, :integer
  end
end
