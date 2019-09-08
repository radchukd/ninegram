class FeedController < ApplicationController
  def index
    unless user_signed_in?
      respond_to do |format|
      format.html { redirect_to new_user_session_path }
      end
    end

    @user = current_user
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    @posts = Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: @user.id)
  end
end