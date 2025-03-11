class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.jsonb :formula, default: {}
      t.string :status, array: true
      t.references :organization, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true

      t.timestamps
    end
  end
end
