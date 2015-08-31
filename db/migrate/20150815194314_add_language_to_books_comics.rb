class AddLanguageToBooksComics < ActiveRecord::Migration
  def change
    add_column :books, :language, :string
    add_column :comics, :language, :string
  end
end
