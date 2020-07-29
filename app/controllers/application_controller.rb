class ApplicationController < ActionController::Base
    include SessionsHelper

    before_action :require_login

    private

    def require_login
        unless logged_in?
            flash[:danger] = 'Not logged in!'
            redirect_to auths_login_path
        end
    end
end
