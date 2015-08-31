class AddScheduleContentsForLive < ActiveRecord::Migration
  def up
    add_column :books, :availability, :integer, :default => 0
    add_column :books, :release_at, :date
    add_column :books, :release_time_zone, :string
    add_column :books, :release_hour, :integer, :default => 0
    
    add_column :comics, :availability, :integer, :default => 0
    add_column :comics, :release_at, :date
    add_column :comics, :release_time_zone, :string
    add_column :comics, :release_hour, :integer, :default => 0
  end
  
  def down
    remove_column :books, :availability
    remove_column :books, :release_at
    remove_column :books, :release_time_zone
    remove_column :books, :release_hour
    
    remove_column :comics, :availability
    remove_column :comics, :release_at
    remove_column :comics, :release_time_zone
    remove_column :comics, :release_hour
  end
end
