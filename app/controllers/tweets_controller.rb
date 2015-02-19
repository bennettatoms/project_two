class TweetsController < ApplicationController

  def index
    @term   = params[:query]
    @tweets = Tweet.search_tweets(params[:query])
    @total = @tweets.reduce(0) { |sum, t| sum + (t[:sentiment] ? (t[:sentiment]['score'] ? t[:sentiment]['score'].to_f : 0) : 0) }
  end
end
