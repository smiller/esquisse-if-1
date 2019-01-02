class Attempt < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts do |t|
      t.string :name
      t.text :description
      t.text :notes
      t.references :task

      t.timestamps
    end
  end
end
