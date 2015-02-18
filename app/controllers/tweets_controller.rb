class TweetsController < ApplicationController

  def index
    @tweets = Tweet.search_tweets(params[:query])
  end
end
