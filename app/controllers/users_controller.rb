class UsersController < ApplicationController
  def show
    @user  = User.where(nickname: params[:nickname]).first
    @posts = Post.paginate(page: params[:page], per_page: 9)
                 .where(user_id: @user.id)
    @followers = @user.followers
    @following = @user.following

    respond_to do |format|
      format.html
      format.js
    end
  end

  def followers
    @user = User.where(nickname: params[:nickname]).first
    @followers = @user.followers
  end

  def following
    @user = User.where(nickname: params[:nickname]).first
    @following = @user.following
  end

  def discover
    @users = User.all
    @users = @users.sort { |u1, u2| u2.passive_relationships.count <=> u1.passive_relationships.count }
  end

  def search
    @users = User.where('nickname LIKE ?', "%#{params[:nickname]}%")
  end
  
  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :avatar, :nickname, :bio)
  end
end