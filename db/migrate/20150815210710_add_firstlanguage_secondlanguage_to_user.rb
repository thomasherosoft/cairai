class AddFirstlanguageSecondlanguageToUser < ActiveRecord::Migration
  def change
    add_column :users, :language_first, :string
    add_column :users, :language_second, :string
  end
end
