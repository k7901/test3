class UsersController < ApplicationController
  
  def index
    @users = User.all
    @user = current_user
  
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
   
      redirect_to user_path(@user.id)
       
  end
   
  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
  
end
