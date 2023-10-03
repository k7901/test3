class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

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
      @user = current_user
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
      if @book.update(books_params)
         flash[:notice] = "You have updated book successfully ."
         redirect_to book_path(@book.id)
      else
        @books = Book.all
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
    user = Book.find(params[:id]).user
    unless user.id == current_user.id
      redirect_to books_path
    end

   end
end
