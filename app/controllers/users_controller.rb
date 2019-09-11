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

  def activity
    @user  = current_user
    @posts = Post.where(user_id: @user.id)
    @posts = @posts.reject { |post| post.get_likes.size == 0 }
    @likes  = []
    @posts.each do |post|
      post.get_likes.each do |like|
        @likes << {
          post: like.votable_id,
          user: User.where(id: like.voter_id).first.nickname,
          time: like.created_at
        }
      end
    end
    @likes = @likes.sort { |p1, p2| p2[:time] <=> p1[:time] }
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