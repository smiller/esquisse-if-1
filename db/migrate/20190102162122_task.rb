class Task < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :link

      t.timestamps
    end
  end
end
