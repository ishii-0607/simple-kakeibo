class AddCreateIncomes < ActiveRecord::Migration[5.2]
  def change
    add_column :incomes, :year_month, :date
    add_column :incomes, :value, :integer
  end
end
