class RemoveToolIdFromScopes < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :scopes, :tools # Supprime la contrainte de clé étrangère
    remove_index :scopes, :tool_id # Supprime l'index pour éviter les erreurs
    remove_column :scopes, :tool_id # Supprime la colonne
  end
end
