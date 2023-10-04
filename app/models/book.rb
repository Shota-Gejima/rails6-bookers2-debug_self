class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def  self.search_for(search, word)
    if search == "perfect"
      @book = Book.where(title: word)
    elsif search == "forword"
      @book = Book.where("title LIKE?", "#{word}%")
    elsif search == "backword"
      @book = Book.where("title LIKE?", "%#{word}")
    elsif search == "partial"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
end
