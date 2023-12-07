class BooksController < ApplicationController

  def index
    
    @books = Book.all
    
    @book_new = Book.new
    
    @user = current_user
    
    @book = Book.new
    
  end

  def show
    
    @book = Book.find(params[:id])
    
    @user = @book.user

    @book_new = Book.new

  end
  
  def create
    
    @book = Book.new(book_params)
    
    @book.user_id = current_user.id
    
    if @book.save
    
      flash[:notice] = "You have created book successfully."
    
      redirect_to book_path(@book.id)
    
    else
      
      @books = Book.all
    
      @book_new = Book.new
    
      @user = current_user
      
      render :index
    
    end
    
  end
  
  
  def edit
    
    is_matching_login_user
    
    @book = Book.find(params[:id])
    
  end
  
  def update
    
    is_matching_login_user
    
    @book = Book.find(params[:id])
    
    if @book.update(book_params)
    
    flash[:notice] = "You have updated book successfully."
    
    redirect_to book_path(@book.id)
    
    else
    
    
      
    render :edit
    
    end
    
  end
  
  def destroy
    
    book = Book.find(params[:id])
    
    book.destroy

    redirect_to '/books'
    
  end

  private

  def is_matching_login_user

    book = Book.find(params[:id])
    
    unless book.user_id == current_user.id
  
      redirect_to "/books"
  
    end
    
  end

  def book_params

    params.require(:book).permit(:title, :body)
  
  end
 
end
