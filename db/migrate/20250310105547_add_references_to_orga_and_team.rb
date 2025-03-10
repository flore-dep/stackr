class AddReferencesToOrgaAndTeam < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :organization, null: false, foreign_key: true
    add_reference :users, :team, null: false, foreign_key: true
  end
end
