class LikesController < ApplicationController
  def create
    session_alert('alert','You dont have permission to create!') unless logged_in?
    tweet = Tweet.find(params[:tweet_id])
    like = Like.new(user: current_user, tweet: tweet)
    if like.save
      session_alert('success', 'This post is liked successfully!', tweet)
    else
      Like.destroy_by(user: current_user, tweet: tweet)
      session_alert('danger', 'This post is disliked', tweet)
    end
  end
end
