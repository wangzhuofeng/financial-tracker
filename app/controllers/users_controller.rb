class UsersController < ApplicationController
    def my_portfolio
        @user_stocks = current_user.user_stocks
        @user = current_user
    end
    
    def my_friends
        @friends = current_user.friends
    end
    
    def show
        @user = User.find(params[:id])
        @user_stocks = @user.user_stocks
    end
    
    def search
        @users = User.search(params[:search_param])
        #debugger
        if @users
            @users = current_user.except_current_user(@users)
            render partial: "friends/lookup"
        else
            render status: :not_found, nothing: true
        end
    end
    
    def edit
      @user = User.find(params[:id])
      if @user == current_user
          render "devise/registrations/edit"
      else
         flash[:danger] = "You don't have access to this action!"
         redirect_to root
      end
    end
    
    def add_friend
        @friend = User.find(params[:friend_id])
        current_user.friendships.build(friend_id: @friend.id)
        
        if current_user.save
            flash[:success] = "Successfully followed this user!" 
        else
            flash[:error] = "There is an error following this user!" 
        end
        redirect_to my_friends_path
    end
end