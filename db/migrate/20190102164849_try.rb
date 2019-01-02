class Try < ActiveRecord::Migration[5.2]
  def change
    create_table :tries do |t|
      t.string :name
      t.text :description
      t.text :notes
      t.references :task
      t.references :attempt

      t.timestamps
    end
  end
end
