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
        if logged_in? && (user_equals?(retweet.user) || user_equals?(retweet.tweet.user) )
            retweet.destroy
            redirect_to tweet_path(retweet.tweet)
        else
            session_alert('alert','You dont have permission to delete!',retweet.tweet) 
        end
    end

    def edit
        @retweet = Retweet.find(params[:id])
        if logged_in? && ( user_equals?(@retweet.user) || user_equals?(@retweet.tweet.user) )
            @tweet = @retweet.tweet
        else
            session_alert('alert','You dont have permission to edit!',@retweet.tweet)
        end 
    end

    def update
        @retweet = Retweet.find(params[:id])
        @tweet = @retweet.tweet
        if logged_in? && ( user_equals?(@retweet.user) || user_equals?(@retweet.tweet.user) )
            if @retweet.update(retweet_params)
                redirect_to tweet_path(@tweet)
            else
                render :edit
            end
        else 
            session_alert('alert','You dont have permission to edit!',@tweet)
        end
    end

    private 

    def retweet_params
        params.require(:retweet).permit(:rtweet)
    end
end
