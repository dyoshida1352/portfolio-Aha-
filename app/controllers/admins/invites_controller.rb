class Admins::InvitesController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:user_id]
      @invites = Invite.where(user_id: params[:user_id]).page(params[:page]).per(10)
    else
      @invites = Invite.all.page(params[:page]).per(10)
    end
  end

  def show
    @invite = Invite.find(params[:id])
  end

  def edit
    @invite = Invite.find(params[:id])
    @invite_tag_list =@invite.invite_tags.pluck(:invite_tag_name).join(",")
  end

  def update
    @invite = Invite.find(params[:id])
    invite_tag_list = params[:invite][:invite_tag_ids].split(',')
    if @invite.update(post_params)
      flash[:notice] = "アイデア募集の内容を変更しました"
      @invite.save_invite_tags(invite_tag_list)
      redirect_to admins_invite_path(@invite)
    else
      render :edit
    end
  end

  def destroy
    invite = Invite.find(params[:id])
    if invite.destroy
      flash[:alert] = "アイデア募集を削除しました"
      redirect_to admins_invites_path
    end
  end

  private

  def post_params
    params.require(:invite).permit(:invite_name, :invite_description, :invite_image)
  end

end
