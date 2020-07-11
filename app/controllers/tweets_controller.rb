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
    @tweet.user = current_user
    if @tweet.save
      redirect_to @tweet
    else
      render :new
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
    session_alert('alert','You dont have permission to edit!', @tweet) unless logged_in? && user_equals?(@tweet.user)
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
    @tweet = Tweet.find(params[:id])
    if logged_in? && user_equals?(@tweet.user)
      @tweet.destroy
      redirect_to root_path
    else
      session_alert('alert','You dont have permission to delete!', @tweet)
    end 
  end

  def display_likes
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      format.js 
      format.json { render json: @tweet }
    end
  end 

  def display_retweets
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      format.js 
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:tweet)
  end
  
end
