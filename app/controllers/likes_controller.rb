class LikesController < ApplicationController
  def create
    tweet = Tweet.find(params[:id])
    like = Like.new(user: current_user,tweet: tweet)
    like.save
  end
end
