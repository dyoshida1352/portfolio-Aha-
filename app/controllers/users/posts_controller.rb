class Users::PostsController < ApplicationController
  before_action :authenticate_user!, {only: [:new, :create, :edit, :update, :destroy]}

  def new
    @post = Post.new
  end

  def create
    @new_post = Post.new
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_ids].split(',')
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = "アイデアを投稿しました"
      redirect_to users_posts_path
    else
      render :new
    end
  end

  def index
    if params[:user_id]
      @posts = Post.where(user_id: params[:user_id]).page(params[:page]).per(9)
    elsif params[:like_id]
      likes = Like.where(user_id: current_user.id).pluck(:post_id)
      @like_post = Post.includes(:likes).find(likes)
      @posts = Kaminari.paginate_array(@like_post).page(params[:page]).per(9)
    elsif params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @tag_post = @tag.posts.all
      @posts = Kaminari.paginate_array(@tag_post).page(params[:page]).per(9)
    else
      @posts = Post.all.page(params[:page]).per(9)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list =@post.tags.pluck(:tag_name).join(",")
    if current_user != @post.user
      redirect_to users_posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @tag_list =@post.tags.pluck(:tag_name).join(",")
    tag_list = params[:post][:tag_ids].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      flash[:notice] = "アイデア投稿の内容を変更しました"
      redirect_to users_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:alert] = "アイデア投稿を削除しました"
      redirect_to users_posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_name, :post_description, :post_image)
  end

end
