class LikesController < ApplicationController
  before_action :find_tweet

  def create
    like = Like.new(user: current_user, tweet: @tweet)
    if like.save
      session_alert('success', 'This post is liked successfully!', @tweet)
    else
      session_alert('notice', 'This post is not liked successfully!', @tweet)
    end
  end

  def destroy
    if Like.destroy_by(user: current_user, tweet: @tweet)
      session_alert('danger', 'This post is disliked', @tweet)
    else
      session_alert('notice', 'This post is not disliked', @tweet)
    end
  end

  private 

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
