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
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash[:notice] = "error"
      render :index
    end
  end



  def show
    @book = Book.find(params[:id])
    @user = current_user
    @books = @user.books
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end
  
  def update
    is_matching_login_user
    @book = Book.find(params[:id])
      if @book.update(books_params)
         flash[:notice] = "You have updated book successfully ."
         redirect_to books_path
      else
        @books = Book.all
        flash.now[:alert] = "error"
        render :edit
      end
       
  end
  
  def destroy
    
    book = Book.find(params[:id])
     flash[:notice] = "Book was successfully destroyed."
    book.destroy
    redirect_to books_path
  end

   private

  def books_params
    params.require(:book).permit(:title, :body)
  end
  
   def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
   end
end
