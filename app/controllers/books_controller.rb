class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
   @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
     flash[:notice] ="You have created book successfully."
     redirect_to book_path(@book.id)
  else
     @books = Book.all
     @user = current_user
     render :index
  end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
  end

  def edit
    @books = Book.find(params[:id])

  end

  def update
    @books = Book.find(params[:id])
    if @books.update(book_params)
      flash[:notice] ="You have updated book successfully."
      redirect_to book_path(@books.id)
    else
      render :edit
    end
  end

  def destroy
    @books = Book.find(params[:id])  # データ（レコード）を1件取得
    @books.destroy  # データ（レコード）を削除
    redirect_to '/books'
  end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end