class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
     @user = current_user
  end

  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash.now[:alert] = "error"
      render :index
    end
  end



  def show
    @book = Book.find(params[:id])
    @user = current_user
    @books = @user.books
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
   
      redirect_to user_path(@user.id)
       
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end

   private

  def books_params
    params.require(:book).permit(:title, :body)
  end
end
