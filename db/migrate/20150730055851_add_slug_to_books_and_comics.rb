class AddSlugToBooksAndComics < ActiveRecord::Migration
  def up
    add_column :books, :url_name, :string
    add_column :comics, :url_name, :string
    add_column :books, :slug, :string
    add_column :comics, :slug, :string
  end
  
  def down
    remove_column :books, :url_name
    remove_column :comics, :url_name
    remove_column :books, :slug
    remove_column :comics, :slug
  end
end
