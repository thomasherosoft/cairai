class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :page_number, :default => 1
      t.integer :bookmarkable_id
      t.string :bookmarkable_type
      t.integer :user_id, :null => false

      t.timestamps null: false
    end
    
    add_index :bookmarks, :user_id
    add_index :bookmarks, [:bookmarkable_id, :bookmarkable_type]
  end
end
