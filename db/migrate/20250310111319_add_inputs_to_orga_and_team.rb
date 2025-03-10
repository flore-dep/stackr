class AddInputsToOrgaAndTeam < ActiveRecord::Migration[7.1]
  def change
    add_column :organizations, :name, :string
    add_column :teams, :name, :string
    add_reference :teams, :organization, null: false, foreign_key: true
  end
end
