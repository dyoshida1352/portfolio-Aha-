class Users::PostsController < ApplicationController
  def new
    @new_post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to users_posts_path
  end

  def index
    @posts = Post.all.page(params[:page]).per(8)
    @post_count = Post.count
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:post_name, :post_description, :post_image)
  end

end
