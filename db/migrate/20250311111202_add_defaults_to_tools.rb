class AddDefaultsToTools < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tools, :formulas, { free: 0, business: 15, enterprise: 50 }.to_json
    change_column_default :tools, :access_types, ["User", "Admin"]
  end
end
