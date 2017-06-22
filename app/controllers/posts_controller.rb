class PostsController < ApplicationController
  before_action :find_post, except: [:index, :new, :create]

  def index
    @posts = Post.post_desc.paginate page: params[:page], per_page: 10
    @hot_users = User.hot_user
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".created_post"
      redirect_to @post
    else
      flash.now[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to post_path @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path current_user
  end

  private

  def post_params
    params.require(:post).permit :title, :body, :user_id
  end

  def find_post
    @post = Post.find params[:id]
  end
end
