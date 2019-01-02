class Phase < ActiveRecord::Migration[5.2]
  def change
    create_table :phases do |t|
      t.string :name
      t.text :description
      t.string :kind
      t.text :notes

      t.references :task
      t.references :attempt

      t.timestamps
    end
  end
end
