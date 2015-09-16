class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    flash_message(:success, "You are now following #{@user.name}")
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    flash_message(:success, "You are no longer following #{@user.name}")
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
