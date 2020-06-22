class Auths::SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:ss][:email]).try(:authenticate, params[:ss][:password])

        if user
            session[:user_id] = user.id
            redirect_to auths_user_path(user)
        else
            flash.now[:danger] = "Email and password doesnt match"
            render :new
        end
    end
end
