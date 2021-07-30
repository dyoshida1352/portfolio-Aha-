class Users::PostCommentsController < ApplicationController
	before_action :authenticate_user_and_admin, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
		@post_comment = PostComment.new(post_comment_params)
		@post_comment.post_id = @post.id
		@post_comment.user_id = current_user.id
		unless @post_comment.save
		  render 'users/posts/show'
		end
  end

  def destroy
    @post = Post.find(params[:post_id])
  	post_comment = @post.post_comments.find(params[:id])
		post_comment.destroy
  end

  private
	def post_comment_params
		params.require(:post_comment).permit(:post_comment)
	end

	def authenticate_user_and_admin
		if user_signed_in?
			authenticate_user!
		elsif admin_signed_in?
			authenticate_admin!
		end
	end

end
