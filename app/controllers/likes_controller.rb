class LikesController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    like = Like.new(user: current_user, tweet: tweet)
    if like.save
      session_alert('success', 'This post is liked successfully!', tweet)
    else
      session_alert('notice', 'This post is not liked successfully!', tweet)
    end
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    if Like.destroy_by(user: current_user, tweet: tweet)
      session_alert('danger', 'This post is disliked', tweet)
    else
      session_alert('notice', 'This post is not disliked', tweet)
    end
  end
end
