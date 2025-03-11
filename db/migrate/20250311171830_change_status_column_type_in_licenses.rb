class ChangeStatusColumnTypeInLicenses < ActiveRecord::Migration[7.1]
  def change
    change_column :licenses, :status, :string, array: false
  end
end
