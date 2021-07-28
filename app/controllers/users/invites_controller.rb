class Users::InvitesController < ApplicationController
  before_action :authenticate_user!, {only: [:new, :create, :edit, :update, :destroy]}

  def new
    @new_invite = Invite.new
  end

  def create
    @new_invite = Invite.new
    @invite = Invite.new(post_params)
    @invite.user_id = current_user.id
    invite_tag_list = params[:invite][:invite_tag_ids].split(',')
    if @invite.save
      @invite.save_invite_tags(invite_tag_list)
      redirect_to users_invites_path
    else
      render :new
    end
  end

  def index
    if params[:user_id]
      @invites = Invite.where(user_id: params[:user_id]).page(params[:page]).per(8)
    else
      @invites = Invite.all.page(params[:page]).per(8)
    end
  end

  def show
    @invite = Invite.find(params[:id])
    @invite_comment = InviteComment.new
  end

  def edit
    @invite = Invite.find(params[:id])
    @invite_tag_list =@invite.invite_tags.pluck(:invite_tag_name).join(",")
    if current_user != @invite.user
      redirect_to users_invites_path
    end
  end

  def update
    @invite = Invite.find(params[:id])
    invite_tag_list = params[:invite][:invite_tag_ids].split(',')
    if @invite.update(post_params)
      @invite.save_invite_tags(invite_tag_list)
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
