class RemoveOrganizationIdFromUser < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :users, :organizations
    remove_column :users, :organization_id
  end
end
