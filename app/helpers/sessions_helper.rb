module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        @current_user.present?
    end

    def logout
        session.clear
        @current_user = nil
    end

    def session_alert(alert,message,path = root_path)
        flash[alert] = message
        redirect_to path
    end
end
