class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]
  
  def destroy
     if @friendship
         @friendship.destroy
         flash[:success] = "You have unfollowed this user."
     else
         flash[:danger] = "You are not following this user."
     end
     redirect_to my_friends_path
        
  end
      
      
  private
  def set_friendship
     @friend = User.find(params[:id])
     @user = current_user
     @friendship = Friendship.where(user: @user, friend: @friend)
  end
end