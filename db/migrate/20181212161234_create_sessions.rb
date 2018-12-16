class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :name
      t.references :track, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
