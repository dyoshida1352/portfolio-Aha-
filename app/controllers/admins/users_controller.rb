class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の内容を変更しました"
       redirect_to admins_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:alert] = "ユーザーを削除しました"
      redirect_to admins_users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :age, :user_image, :email)
  end

end
