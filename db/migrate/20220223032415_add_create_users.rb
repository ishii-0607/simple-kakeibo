class AddCreateUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cost_id, :integer
  end
end
