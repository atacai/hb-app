class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
    	t.string :name
      t.integer :duration_minute
      t.time :start_time
      t.time :end_time
      t.references :session, foreign_key: true
      t.references :proposal, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
