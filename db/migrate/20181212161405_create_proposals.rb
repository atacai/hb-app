class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals do |t|
      t.string :name
      t.integer :duration_minute
      t.references :conference, foreign_key: true

      t.timestamps
    end
  end
end
