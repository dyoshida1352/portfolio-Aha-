class Admins::PostsController < ApplicationController

  def index
    if params[:user_id]
      @posts = Post.where(user_id: params[:user_id]).page(params[:page]).per(10)
    else
      @posts = Post.all.page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list =@post.tags.pluck(:tag_name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_ids].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      redirect_to admins_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admins_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:post_name, :post_description, :post_image)
  end


end