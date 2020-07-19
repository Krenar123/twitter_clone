module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id]) 
        end
    end

    def logged_in?
        current_user.present?
    end

    def logout
        session.clear
        @current_user = nil
    end

    def session_alert(alert,message,path = root_path)
        flash[alert] = message
        redirect_to path and return
    end

    def user_equals?(other)
        current_user == other
    end

    def post_liked?(tweet)
        Like.exists?(user:current_user, tweet: tweet)
    end

    def most_likely_tweets
        tweets = Like.group(:tweet_id).count.sort_by{|_key,value| value}.reverse.take(4).map {|i| i[0] }
        Tweet.find(tweets)
    end
end
