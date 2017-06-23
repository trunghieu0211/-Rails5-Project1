class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]

  def index
    @users = User.user_desc.paginate page: params[:page], per_page: 12
  end

  def show
    @user = User.find_by id: params[:id]
    @posts = @user.posts.post_desc.paginate page: params[:page], per_page: 10
    render file: "public/404.html", layout: false unless @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end
end
