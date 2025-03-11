class CreateLicenses < ActiveRecord::Migration[7.1]
  def change
    create_table :licenses do |t|
      t.date :start_date
      t.date :end_date
      t.string :status, array: true
      t.string :access_type, array: true
      t.references :plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :scope, null: false, foreign_key: true

      t.timestamps
    end
  end
end
