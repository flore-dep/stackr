class AddInputsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :string
    add_column :users, :start_date, :date
    add_column :users, :end_date, :date
  end
end
