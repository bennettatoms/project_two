class TweetSentimentsController < ApplicationController
  before_action :set_sentiment, only: [:show, :destroy]
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user,   except: [:new, :create, :index, :show]

  def index
    render action: :index
  end

  def show
    @sentiment = TweetSentiment.find(params[:id])
  end

  def create
    # has_many :through
    # @sentiment = TweetSentiment.new(tweet_sentiment_params)
    # current_user.tweet_sentiments << @sentiment
    @sentiment = current_user.tweet_sentiments.new(tweet_sentiment_params) # automagically sets user_id: current_user.id
    # p = tweet_sentiment_params
    # @sentiment = TweetSentiment.new(search_term: p[:search_term], sentiment_score: p[:sentiment_score], user_id: current_user.id)
    if @sentiment.save
      flash[:success] = "Tweet sentiment analysis saved to your profile."
      redirect_to user_path current_user
    else
      redirect_to searches_path
    end
  end

  def destroy
    @sentiment.destroy
    flash[:success] = "Tweet sentiment analysis deleted from your profile."
    redirect_to user_path current_user #, notice: "Tweet sentiment analysis deleted."
  end  

  private
    def tweet_sentiment_params
      params.require(:tweet_sentiment).permit(:search_term, :sentiment_score)
    end

    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end
    def set_sentiment
      @sentiment = TweetSentiment.find(params[:id])
    end

    def correct_user
      unless current_user?(@sentiment.user) || current_user.admin?
        redirect_to user_path(current_user)
      end
    end
end

