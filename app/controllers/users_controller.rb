class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  	# @book = Book.find(params[:id]) 
    @book = Book.new
    @user = User.find(params[:id])
  end
  
  def index
    @books = Book.all
  	@user = current_user
  	@book = Book.new
  	@users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'

      redirect_to user_path(current_user)
      # binding.pry
    else
      render "edit"
    end
  end


  def new
  end

    private
    def book_params
      params.require(:book).permit(:title, :opinion)
    end

    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

end
