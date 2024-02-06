class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.belongs_to :movie
      t.belongs_to :actor
      t.string :character_name

      t.timestamps
    end
  end
end
