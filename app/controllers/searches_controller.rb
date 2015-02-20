class SearchesController < ApplicationController
  before_action :signed_in_user, except: [:index, :show]

  def new
    # @term   = params[:query]
    # @tweets = TweetSentiment.search_tweets(params[:query])
    # @total = @tweets.reduce(0) { |sum, t| sum + (t[:sentiment] ? (t[:sentiment]['score'] ? t[:sentiment]['score'].to_f : 0) : 0) }
  end

  def index
    @term   = params[:query]
    @tweets = TweetSentiment.search_tweets(params[:query])
    @total = @tweets.reduce(0) { |sum, t| sum + (t[:sentiment] ? (t[:sentiment]['score'] ? t[:sentiment]['score'].to_f : 0) : 0) }
  end

  private
    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end
end
