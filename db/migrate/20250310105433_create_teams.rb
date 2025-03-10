class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|

      t.timestamps
    end
  end
end
