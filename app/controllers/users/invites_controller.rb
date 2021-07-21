class Users::InvitesController < ApplicationController
  def new
    @new_invite = Invite.new
  end

  def create
    @new_invite = Invite.new
    @invite = Invite.new(post_params)
    @invite.user_id = current_user.id
    if @invite.save
      redirect_to users_invites_path
    else
      render :new
    end
  end

  def index
    @invites = Invite.all.page(params[:page]).per(8)
    @invite_count = Invite.count
  end

  def show
    @invite = Invite.find(params[:id])
    @invite_comment = InviteComment.new
  end

  def edit
    @invite = Invite.find(params[:id])
    if current_user != @invite.user
      redirect_to users_invites_path
    end
  end

  def update
    @invite = Invite.find(params[:id])
    if @invite.update(post_params)
      redirect_to users_invite_path(@invite)
    else
      render :edit
    end
  end

  def destroy
    invite = Invite.find(params[:id])
    invite.destroy
    redirect_to users_invites_path
  end

  private

  def post_params
    params.require(:invite).permit(:invite_name, :invite_description, :invite_image)
  end

end