#+------------------------------------------------------------+
# * File Name         : user.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable ,:lockable
  attr_accessor :login

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}, format: { with: /\A[a-zA-Z0-9]+\z/, message: "Please enter your correct username.  Only characters A-Z, a-z and '-' are  acceptable."}
  validates :address, format: { with: /[\sA-Za-z0-9]/, message: "Please enter your correct address.  Only alphanumeric characters are allowed." }, :if => lambda { self.address.present? }
  validates_numericality_of :age, :message => "Please enter your correct age. Allow number's only.", :if => lambda { self.age.present? }
  validates_inclusion_of :age, :in => 0..99, :message => "Please enter age between 0..99 only.", :if => lambda { self.age.present? }
  validates_format_of :password, :with => /\A(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/, :message => "Invalid password, Should contains at least one special charater, one numeric digit.", :if => lambda { self.password.present? }
  validates :birthday, :presence => { :message => "Please enter proper birthday, can't be blank" }

  has_many :books, :dependent => :destroy
  has_many :comics, :dependent => :destroy
  has_many :songs, :dependent => :destroy
  has_many :comments
  has_one :image, as: :imageable, :dependent => :destroy

  after_create :send_welcome_email
  after_create :set_default_image
  after_save :update_age
  
  scope :filter_sex_users, -> (ids, sex) { where("id in (?) AND sex = ?", ids, sex) }
  
  
  # Logged in users fullname
  def fullname
    "#{first_name} #{last_name}".camelize
  end

  # Logged in users profile picture
  def profile_picture
    self.image.nil? ? Image.new : self.image
  end

  # New register user will get a welcome email via these method
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end

  # New register set default image
  def set_default_image
    Image.new({:imageable_id => self.id, :imageable_type => self.class.name}).save(validate: false)
  end

  # Update the profile picture for the registered users
  def update_profile_picture photo
    if valid_extension?(File.extname(photo.original_filename))
      self.image.update_attributes(:photo => photo)
    else
      self.errors.add(:photo, "Invalid profile picture format, Allow only(jpg,jpeg,png) images.")
    end
  end

  # Override the datavase authentication for the users to login vai email or username
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  # Validation for the users profile picture
  def valid_extension?(filename_extname)
    %w( .jpg .jpeg .png ).include? filename_extname.downcase
  end
  
  # Update the age of the user on every login and if update the profile any time
  def update_age
    today = Date.today
    age = today.year - birthday.year
    age -= 1 if birthday.strftime("%m%d").to_i > today.strftime("%m%d").to_i
    self.update_columns(:age => age)
  end
  
  # Check the user's age resterctions for reading the books and comics.
  # 0 - Means every one can see, no age resterictions
  # 1 - Means only the users who have the age between 13 to 17 can see
  # 2 - Means only the users who have 18 or above age can see   
  def age_restriction_on_resource(resource)
    case resource.age_restriction
    when 1
      (self.age >= 13 ) ? false : true
    when 2
      (self.age >= 18) ? false : true
    else
      false
    end      
  end
  
  # Get the books data sort by the highest like votes
  def get_highest_liked_books
    Book.sort_by_highest_liked_books self 
  end
  
  # Get the books data sort by the highest dislike votes
  def get_highest_disliked_books
    Book.sort_by_highest_disliked_books self
  end
  
  # Get the comics data sort by the highest like votes
  def get_highest_liked_comics
    Comic.sort_by_highest_liked_comics self 
  end
  
  # Get the comics data sort by the highest dislike votes
  def get_highest_disliked_comics
    Comic.sort_by_highest_disliked_comics self
  end

  #set default sex for user
  def user_default_sex
    User.sex = 'Unidentified' if user.sex.nil?
  end
  
  def get_unique_visited_books
    Impression.select(:impressionable_id).distinct.where("impressionable_type = 'Book' AND user_id = ?", self.id)
  end
  
  def get_unique_visited_comics
    Impression.select(:impressionable_id).distinct.where("impressionable_type = 'Comic' AND user_id = ?", self.id)
  end
end