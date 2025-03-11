class CreateTools < ActiveRecord::Migration[7.1]
  def change
    create_table :tools do |t|

      t.string :name
      t.string :category
      t.jsonb :formulas, default: {}
      t.string :access_types, array: true
      t.timestamps
    end
  end
end
