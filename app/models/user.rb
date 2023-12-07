class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  
  has_many :books, dependent: :destroy
  
  validates :name, length: { minimum: 2, maximum: 20}, uniqueness: true
  
  validates :introduction, length: { maximum: 50}
  
  def get_profile_image(width,height)
      
    unless profile_image.attached?
    
      file_path = Rails.root.join('app/assets/images.1/no_image.jpg')
    
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    
    end
    
      profile_image.variant(resize_to_limit: [width,height]).processed
  
  end
  
  GUEST_USER_EMAIL = "guest@example.com"
    
  def  self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
