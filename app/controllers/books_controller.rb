class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id), notice: "successfully created"
    else
      @book1 = Book.all
      @user1 = User.all
      render :index
    end
  end

  def index
    @book = Book.new
    @book1 = Book.all
  end

  def show
    @book1 = Book.find(params[:id])
    @user = @book1.user
    @book = Book.new

  end

  def edit
    @book1 = Book.find(params[:id])
    if @book1.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book1 = Book.find(params[:id])
    @book1.user_id = current_user.id
    if @book1.update(book_params)
    redirect_to book_path(@book1.id), notice: "successfully created"
    else
      render :edit
    end
  end

  def destroy
    @book1 = Book.find(params[:id])
    @book1.user_id = current_user.id
    @book1.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end
end
