class RelationshipsController < ApplicationController
  before_action :user_signed_in?
  
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user) if current_user != @user
    
    respond_to do |format|
      format.html { redirect_to user_path(@user.nickname), notice: "Successfully subscribed to @#{@user.nickname}" }
    end
  end
  
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user) if current_user != @user

    respond_to do |format|
      format.html { redirect_to user_path(@user.nickname), notice: "Successfully unsubscribed from @#{@user.nickname}" }
    end
  end
end