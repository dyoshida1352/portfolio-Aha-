class Users::UsersController < ApplicationController
  before_action :authenticate_user!, {only: [:edit, :update, :quit, :destroy]}

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to users_user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の内容を変更しました"
      redirect_to users_user_path(@user)
    else
      render :edit
    end
  end

  def quit
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:alert] = "退会しました"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :user_image, :email)
  end
end
