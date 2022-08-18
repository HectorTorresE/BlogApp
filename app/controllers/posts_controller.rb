class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @is_liked = @post.liked?(current_user)
    @comments = @post.comments
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    permitted = params.require(:post).permit(:title, :text)
    @post = Post.new(author: current_user, text: permitted[:text], title: permitted[:title], commentscounter: 0,
                     likescounter: 0)
    if @post.valid? && @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render 'new'
    end
  end
end
