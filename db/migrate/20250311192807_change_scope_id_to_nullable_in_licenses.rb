class ChangeScopeIdToNullableInLicenses < ActiveRecord::Migration[7.1]
  def change
    change_column_null :licenses, :scope_id, true
  end
end
