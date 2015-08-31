class AddAdsTurnOffCheckboxToBookAndComic < ActiveRecord::Migration
  def up
    add_column :books, :turn_off_ads, :boolean, :default => false
    add_column :comics, :turn_off_ads, :boolean, :default => false
  end
  
  def down
    remove_column :books, :turn_off_ads
    remove_column :comics, :turn_off_ads
  end
end
