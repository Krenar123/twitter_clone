class LikesController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    if logged_in?
      like = Like.new(user: current_user, tweet: tweet)
      like.save
      session_alert('success', 'This post is liked successfully!', tweet)
    else
      session_alert('alert','You dont have permission to like!')
    end
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    if logged_in?
      Like.destroy_by(user: current_user, tweet: tweet)
      session_alert('danger', 'This post is disliked', tweet)
    else
      session_alert('alert','You dont have permission to dislike!')
    end
  end
end
