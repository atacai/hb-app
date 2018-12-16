class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :name
      t.references :conference, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
