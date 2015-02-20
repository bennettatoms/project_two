class TweetSentimentsController < ApplicationController
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user,   except: [:new, :create, :index, :show]

  def index
    render action: :index
  end

  def show
    @sentiment = TweetSentiment.find(params[:id])
  end

  def create
    @sentiment = TweetSentiment.new(tweet_sentiment_params)
    current_user.tweet_sentiments << TweetSentiment.new(tweet_sentiment_params) # automagically sets user_id: current_user.id
    # if @item is valid, it returns a truthy value
    if @sentiment.save
      flash[:success] = "Tweet sentiment analysis saved to your profile."
      redirect_to user_path
    else
      render results
    end
  end

  def destroy
    @sentiment = TweetSentiment.find(params[:id])
    @sentiment.destroy
    redirect_to user_path, notice: "Tweet sentiment analysis deleted."
  end  

  private
    def sentiment_params
      params.require(:tweet_sentiment).permit(:search_term, :sentiment_score)
    end

    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end
end

