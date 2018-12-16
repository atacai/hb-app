class CreatePriorityConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :priority_configurations do |t|
      t.string :name

      t.timestamps
    end
  end
end
