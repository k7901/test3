class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(books_params)
    byebug
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to books_path
    else
      @books = Book.all
      flash.now[:alert] = "error"
      render :index
    end
  end



  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

   private

  def books_params
    params.require(:book).permit(:title, :opinion)
  end
end
