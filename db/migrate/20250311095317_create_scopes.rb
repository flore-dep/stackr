class CreateScopes < ActiveRecord::Migration[7.1]
  def change
    create_table :scopes do |t|
      t.references :team, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
