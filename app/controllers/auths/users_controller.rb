class Auths::UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :show, :create]

    def new 
        @user = User.new
    end

    def show 
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
        session_alert('alert','You dont have permission to edit!', auths_user_path(@user)) unless user_equals?(@user)
    end

    def update
        @user = User.find(params[:id])
        if user_equals?(@user)
            if @user.update(user_params)
                redirect_to auths_user_path(@user)
            else
                render :edit 
            end
        else
            session_alert('alert','You dont have permission to edit!', auths_user_path(@user)) 
        end
    end

    def create 
        @user = User.new(user_params)

        if @user.save
            log_in(@user)
            redirect_to auths_user_path(@user)
        else
            flash.now[:danger] = @user.errors.full_messages.to_sentence
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
end
