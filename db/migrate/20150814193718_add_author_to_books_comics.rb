class AddAuthorToBooksComics < ActiveRecord::Migration
  def change
    add_column :books, :author, :string
    add_column :comics, :author, :string
  end
end
