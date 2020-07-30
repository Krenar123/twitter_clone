class Auths::UsersController < ApplicationController
    skip_before_action :require_login, only: [:new, :show, :create]
    before_action :find_user, except: [:new, :create]
    before_action :correct_user, only: [:edit, :update]

    def new 
        @user = User.new
    end

    def show 
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to auths_user_path(@user)
        else
            render :edit 
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

    def find_user
        @user = User.find(params[:id])
    end

    def correct_user
        unless user_equals?(@user)
            flash[:danger] = "You dont have permission!"
            redirect_to root_path
        end
    end
end
