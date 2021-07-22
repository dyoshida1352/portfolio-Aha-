class Users::InviteCommentsController < ApplicationController
  def create
    @invite = Invite.find(params[:invite_id])
		@invite_comment = InviteComment.new(invite_comment_params)
		@invite_comment.invite_id = @invite.id
		@invite_comment.user_id = current_user.id
		unless @invite_comment.save
  		render 'users/invites/show'
		end
  end

  def destroy
    @invite = Invite.find(params[:invite_id])
  	invite_comment = @invite.invite_comments.find(params[:id])
		invite_comment.destroy
  end

  private
	def invite_comment_params
		params.require(:invite_comment).permit(:invite_comment)
	end

end
