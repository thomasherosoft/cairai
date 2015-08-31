class AddLicenseGenreAgeRestrictionToBooksAndComics < ActiveRecord::Migration
  def up
    add_column :books, :license_type, :string, :default => ""
    add_column :books, :genre, :string, :default => ""
    add_column :books, :age_restriction, :integer, :default => 0
    add_column :books, :login_require, :boolean, :default => false
    add_column :comics, :license_type, :string, :default => ""
    add_column :comics, :genre, :string, :default => ""
    add_column :comics, :age_restriction, :integer, :default => 0
    add_column :comics, :login_require, :boolean, :default => false
    # Age Restriction details
    # 0 - Everyone
    # 1 - Age 13 and Up 
    # 2 - Age 17 and Up
  end
  
  def down
    remove_column :books, :license_type
    remove_column :books, :genre
    remove_column :books, :age_restriction
    remove_column :books, :login_require
    remove_column :comics, :license_type
    remove_column :comics, :genre, :string
    remove_column :comics, :age_restriction
    remove_column :comics, :login_require
  end
end
