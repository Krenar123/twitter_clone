class RetweetsController < ApplicationController
    def create
        tweet = Tweet.find(params[:tweet_id])
        tweet.retweets.create(retweet_params)
        redirect_to tweet
    end

    def destroy
        retweet = Retweet.find(params[:id])
        retweet.destroy

        redirect_to tweet_path(retweet.tweet)
    end

    def edit
        @retweet = Retweet.find(params[:id])
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
