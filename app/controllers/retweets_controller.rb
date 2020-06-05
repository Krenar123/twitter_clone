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

    private 

    def retweet_params
        params.require(:retweet).permit(:rtweet)
    end
end
