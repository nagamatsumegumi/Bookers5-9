class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
  	@book = Book.find(params[:id])
    @newbook = Book.new
  end

  def new
  	@book = Book.new
  end

  def create
        @books = Book.all
  	    @book = Book.new(book_params)
        @book.user_id = current_user.id
     if @book.save
        redirect_to book_path(@book), notice: "You have creatad book successfully."
     else
        render action: :index
     end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	book = Book.find(params[:id])
 if book.update(book_params)
    redirect_to book_path(book), notice: "You have updated book successfully."
 else
    render action: :edit
 end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :opinion)
  end
end
