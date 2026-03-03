class AddArchivedToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :archived, :boolean, default: false, null: false
  end
end
