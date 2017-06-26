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
end