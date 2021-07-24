class Users::PostsController < ApplicationController
  def new
    @new_post = Post.new
  end

  def create
    @new_post = Post.new
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      tag_list = tag_params[:tag_names].split(/[[:blank:]]+/).select(&:present?)
      @post.save_tags(tag_list)
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
    tag = tag_params[:tag_names]
    if @post.update(post_params)
      tag_list = tag.split(/[[:blank:]]+/).select(&:present?)
      @post.save_tags(tag_list)
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

  def tag_params
    params.require(:post).permit(:tag_names)
  end

end
