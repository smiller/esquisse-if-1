class TagLink < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_links do |t|
      t.references :tag
      t.references :taggable, polymorphic: true, index: true
    end
  end
end
