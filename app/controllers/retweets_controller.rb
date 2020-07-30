class RetweetsController < ApplicationController
    before_action :find_retweet, except: [:create]
    before_action :correct_user, only: [:destroy, :edit, :update]

    def create
        tweet = Tweet.find(params[:tweet_id])
        retweet = tweet.retweets.create(retweet_params)
        retweet.user = current_user

        if retweet.save
            redirect_to tweet
        else
            session_alert('alert', retweet.errors.full_messages.to_sentence, tweet)
        end
    end

    def destroy
        @retweet.destroy
        redirect_to tweet_path(@retweet.tweet)
    end

    def edit
        @tweet = @retweet.tweet
    end

    def update
        @tweet = @retweet.tweet
        if @retweet.update(retweet_params)
            redirect_to tweet_path(@tweet)
        else
            render :edit
        end
    end

    private 

    def retweet_params
        params.require(:retweet).permit(:rtweet)
    end

    def find_retweet
        @retweet = Retweet.find(params[:id])
    end

    def correct_user
        unless user_equals?(@retweet.user) || user_equals?(@retweet.tweet.user) 
            session_alert('alert', 'You dont have permission!', @retweet.tweet)
        end
    end
end
