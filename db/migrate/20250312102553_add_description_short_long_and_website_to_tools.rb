class AddDescriptionShortLongAndWebsiteToTools < ActiveRecord::Migration[7.1]
  def change
    add_column :tools, :description, :text
    add_column :tools, :long_description, :text
    add_column :tools, :website, :string
  end
end
