class BookCommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = BookComment.find(params[:id])
    comment.destroy
    redirect_to book_path(book)
  end

  private
  
  def book_params
    params.require(:book_comment).permit(:comment)
  end
end

