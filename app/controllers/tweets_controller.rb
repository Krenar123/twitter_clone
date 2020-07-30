class TweetsController < ApplicationController
  skip_before_action :require_login, only: [:index, :display_likes, :display_retweets]
  before_action :find_tweet, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @tweets = Tweet.all
  end

  def show
    @retweets = @tweet.retweets
  end

  def new
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
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end

  def display_likes
    respond_to do |format|
      format.js 
      format.json { render json: @tweet }
    end
  end 

  def display_retweets
    respond_to do |format|
      format.js 
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:tweet)
  end
  
  def find_tweet
    @tweet = Tweet.find(params[:id])
  end

  def correct_user
    unless user_equals?(@tweet.user)
        flash[:danger] = "You dont have permission!"
        redirect_to root_path
    end
  end
end
