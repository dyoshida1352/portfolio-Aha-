class Users::InvitesController < ApplicationController
  before_action :authenticate_user!, {only: [:new, :create, :edit, :update, :destroy]}

  def new
    @invite = Invite.new
  end

  def create
    @new_invite = Invite.new
    @invite = Invite.new(invite_params)
    @invite.user_id = current_user.id
    invite_tag_list = params[:invite][:invite_tag_ids].split(',')
    if @invite.save
      @invite.save_invite_tags(invite_tag_list)
      flash[:notice] = "アイデア募集を投稿しました"
      redirect_to users_invites_path
    else
      render :new
    end
  end

  def index
    if params[:user_id]
      @invites = Invite.where(user_id: params[:user_id]).page(params[:page]).per(20)
    else
      @invites = Invite.all.page(params[:page]).per(20)
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
    @invite_tag_list =@invite.invite_tags.pluck(:invite_tag_name).join(",")
    invite_tag_list = params[:invite][:invite_tag_ids].split(',')
    if @invite.update(invite_params)
      @invite.save_invite_tags(invite_tag_list)
      flash[:notice] = "アイデア募集の内容を変更しました"
      redirect_to users_invite_path(@invite)
    else
      render :edit
    end
  end

  def destroy
    invite = Invite.find(params[:id])
    if invite.destroy
      flash[:alert] = "アイデア募集を削除しました"
      redirect_to users_invites_path
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:invite_name, :invite_description, :invite_image)
  end

end
