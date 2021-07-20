class Users::InviteCommentsController < ApplicationController
  def create
    @invite = Invite.find(params[:invite_id])
		@invite_comment = InviteComment.new(invite_comment_params)
		@invite_comment.invite_id = @invite.id
		@invite_comment.user_id = current_user.id
		if @invite_comment.save
  		redirect_to users_invite_path(@invite.id)
		else
		  render 'users/invites/show'
		end
  end

  def destroy
    @invite = Invite.find(params[:invite_id])
  	invite_comment = @invite.invite_comments.find(params[:id])
		invite_comment.destroy
		redirect_to request.referer
  end

  private
	def invite_comment_params
		params.require(:invite_comment).permit(:invite_comment)
	end

end
