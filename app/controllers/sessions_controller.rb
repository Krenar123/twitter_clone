class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:ss][:email])

        if user&.authenticate(params[:ss][:password])
            redirect_to user
        else
            flash.now[:danger] = "Email and password doesnt match"
            render :new
        end
    end
end
