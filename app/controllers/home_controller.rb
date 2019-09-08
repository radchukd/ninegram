class HomeController < ApplicationController
  def index
    unless user_signed_in?
      respond_to do |format|
      format.html { redirect_to new_user_session_path }
      end
    end
  end
end
