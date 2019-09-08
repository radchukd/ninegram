class UsersController < ApplicationController
  def show
    @user = User.where(nickname: params[:nickname]).first
    @posts = @user.posts
    @followers = @user.followers
    @following = @user.following
  end

  def followers
    @user = User.where(nickname: params[:nickname]).first
    @followers = @user.followers
  end

  def following
    @user = User.where(nickname: params[:nickname]).first
    @following = @user.following
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :avatar, :nickname, :bio)
  end
end