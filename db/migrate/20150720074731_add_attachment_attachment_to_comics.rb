class AddAttachmentAttachmentToComics < ActiveRecord::Migration
  def self.up
    change_table :comics do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :comics, :attachment
  end
end
