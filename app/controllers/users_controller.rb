class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:user_profile_update] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def create
    book = Book.new(book_params)
    book.save
    redirect_to user_path(@user.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  def follow
    @user = User.find(params[:id])
  end
  
  def follower
    @user = User.find(params[:id])
  end


  private
  def user_params
   params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
