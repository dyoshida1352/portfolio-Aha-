class Users::PostsController < ApplicationController
  def new
    @new_post = Post.new
  end

  def create
    @new_post = Post.new
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to users_posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all.page(params[:page]).per(8)
    @post_count = Post.count
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if current_user != @post.user
      redirect_to users_posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to users_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to users_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:post_name, :post_description, :post_image)
  end

end
