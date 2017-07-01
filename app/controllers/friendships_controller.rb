class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]
  
  def destroy
     if @friendship
        @friendship.destroy
        flash[:success] = t("you_have_unfollowed_this_user")
     else
        flash[:danger] = "You are not following this user."
     end
     redirect_to my_friends_path
        
  end
      
      
  private
  def set_friendship
     @friendship = current_user.friendships.where(friend_id: params[:id]).first
  end
end