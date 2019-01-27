class BooksController < ApplicationController
  before_action :authenticate_user!


  def show
    @book = Book.new
    @user = current_user
    @current_book = Book.find(params[:id])
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def new
  end


  def edit
        @book = Book.find(params[:id])
  end

  def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
      flash[:notice] = 'Book was successfully created.'
  		redirect_to book_path(@book.id)
      # エラー情報を保持できない
  	else
      @user = current_user
      @books = Book.all
  		render :index
      # binding.pry

      # books/index.html.erbを呼び出してる
      # エラー情報を保持できる
  	end
  end

  def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
          flash[:notice] = 'Book was successfully Updated.'
        redirect_to book_path(@book.id)
      else
        @user = current_user
        @books = Book.all
        render :index
      end
    end

  private
   def book_params
   	params.require(:book).permit(:title, :opinion, :user_id)
   end
end
