class CreateConferences < ActiveRecord::Migration[5.2]
  def change
    create_table :conferences do |t|
      t.string :name
      t.boolean :active
      t.integer :priority_configuration_id

      t.timestamps
    end
  end
end
