class Note < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :name
      t.string :description
      t.references :notable, polymorphic: true, index: true
      t.datetime :set_at

      t.timestamps
    end
  end
end
