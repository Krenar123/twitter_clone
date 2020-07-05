class RetweetsController < ApplicationController
    def create
        tweet = Tweet.find(params[:tweet_id])
        if logged_in?
            retweet = tweet.retweets.create(retweet_params)
            retweet.user = current_user
            if retweet.save
                redirect_to tweet
            else
                session_alert('alert', retweet.errors.full_messages.to_sentence, tweet)
            end
        else
            session_alert('alert','Not logged in', tweet) 
        end
    end

    def destroy
        retweet = Retweet.find(params[:id])
        if logged_in?
            retweet.destroy
            redirect_to tweet_path(retweet.tweet)
        else
            session_alert('alert','Not logged in',retweet.tweet) 
        end
    end

    def edit
        @retweet = Retweet.find(params[:id])
        session_alert('alert','Not logged in',@retweet.tweet) unless logged_in?
        @tweet = @retweet.tweet
    end

    def update
        @retweet = Retweet.find(params[:id])
        @tweet = @retweet.tweet
        if @retweet.update(retweet_params)
            redirect_to tweet_path(@retweet.tweet)
        else
            render :edit
        end
    end

    private 

    def retweet_params
        params.require(:retweet).permit(:rtweet)
    end
end
