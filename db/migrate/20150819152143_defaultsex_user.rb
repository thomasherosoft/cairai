class DefaultsexUser < ActiveRecord::Migration
  def change
  	change_column :users, :sex, :string, :default => "Unidentified"
  end
end
