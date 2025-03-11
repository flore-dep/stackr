class ChangeAccessColumnTypeInLicenses < ActiveRecord::Migration[7.1]
  def change
    change_column :licenses, :access_type, :string, array: false
  end
end
