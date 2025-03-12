class ChangeStatusColumnTypeInPlans < ActiveRecord::Migration[7.1]
  def change
    change_column :plans, :status, :string, array: false
  end
end
