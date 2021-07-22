class Users::PostCommentsController < ApplicationController
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

end
