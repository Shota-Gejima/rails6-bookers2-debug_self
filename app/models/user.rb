class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50}
  

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  def  self.search_for(search, word)
    if search == "perfect"
      @user = User.where(name: word)
    elsif search == "forword"
      @user =User.where("name LIKE?", "#{word}%")
    elsif search == "backword"
      @user =User.where("name LIKE?", "%#{word}")
    elsif search == "partial"
      @user =User.where("name LIKE?", "%#{word}%")
    else
      @user =User.all
    end
  end
end
