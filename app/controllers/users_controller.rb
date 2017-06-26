class UsersController < ApplicationController
    def my_portfolio
        debugger
        @user_stocks = current_user.user_stocks
        @user = current_user
    end
end