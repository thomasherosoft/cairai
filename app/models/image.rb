#+------------------------------------------------------------+
# * File Name         : image.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  validates :photo, :presence => { :message => "Invalid picture format, Allow only(jpg,jpeg,png) images." }
  has_attached_file :photo,
                    :styles => { :medium => "350x350>", :thumb => "100x100>", :small => "70x70>", :tiny => "35x35>"},
                    :convert_options => { :medium => "-quality 85 -strip", :thumb => "-quality 85 -strip", :small => "-quality 85 -strip", :tiny => "-quality 85 -strip"},
                    :url => "/system/photos/:id/:style/:basename.:extension",
                    :default_url => "/system/default/:style/missing.png",
                    :path => ":rails_root/public/system/photos/:id/:style/:basename.:extension",
                    :size => { :in => 0.megabytes..5.megabytes }


  validates_attachment :photo, :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] }
end