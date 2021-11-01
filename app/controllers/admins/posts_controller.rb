class Admins::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:user_id]
      @posts = Post.where(user_id: params[:user_id]).page(params[:page]).per(20).order(created_at: :desc)
    else
      @posts = Post.all.page(params[:page]).per(20).order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @tag_names =@post.join_tag_names
  end

  def update
    @post = Post.find(params[:id])
    @tag_names =@post.join_tag_names
    tags = params[:post][:tag_ids].split(',')
    if @post.update(post_params)
      @post.save_tags(tags)
      flash[:notice] = "アイデア投稿の内容を変更しました"
      redirect_to admins_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:alert] = "アイデア投稿を削除しました"
      redirect_to admins_posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_name, :post_description, :post_image)
  end


end
