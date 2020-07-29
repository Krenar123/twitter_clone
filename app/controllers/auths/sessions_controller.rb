class Auths::SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    
    def new
    end

    def create
        user = User.find_by(email: params[:ss][:email].downcase).try(:authenticate, params[:ss][:password])
        # Alternative -- User.find_by(email: params[:ss][:email])&.authenticate(params[:ss][:password])
        if user
            log_in(user)
            redirect_to auths_user_path(user)
        else
            flash.now[:danger] = "Email and password doesnt match"
            render :new
        end
    end

    def destroy
        logout
        redirect_to root_path
    end
end
