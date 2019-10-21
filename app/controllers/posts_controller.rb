class PostsController < ApplicationController
  before_action :set_post, only:  [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def show

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if (@post.save)
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if (@post.update(post_params))
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :user_id, :content)
  end

  def require_same_user
    if current_user != @post.user
      flash[:danger] = "You can only edit or delete your own article"
      redirect_to root_path
    end
  end
end