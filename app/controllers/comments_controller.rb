class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.create comment_params
    @comment.user_id = current_user.id

    if @comment.save
      render json: {status: :success, html: render_to_string(@comment)}
    else
      render json: {status: :error, html:render_to_string(@comment)}
    end
  end

  def edit
  end

  def update
    if @comment.update comment_params
      redirect_to post_path @post
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path @post
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def find_post
    @post = Post.find params[:post_id]
  end

  def find_comment
    @comment = @post.comments.find params[:id]
  end
end
