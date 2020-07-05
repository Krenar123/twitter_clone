class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
    @retweets = @tweet.retweets
  end

  def new
    session_alert('alert','Not logged in') unless logged_in?
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to @tweet
    else
      render :new
    end
  end

  def edit
    session_alert('alert','Not logged in') unless logged_in?
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to @tweet
    else
      render :edit
    end
  end

  def destroy
    session_alert('alert','Not logged in') unless logged_in?
    @tweet = Tweet.find(params[:id])
    @tweet.destroy

    redirect_to root_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:tweet)
  end
  
end
