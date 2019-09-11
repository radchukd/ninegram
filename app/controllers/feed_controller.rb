class FeedController < ApplicationController
  before_action :authenticate_user!

  def index
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    @posts = Post.paginate(page: params[:page], per_page: 15)
                 .where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: current_user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end
end