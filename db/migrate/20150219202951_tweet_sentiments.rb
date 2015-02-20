class TweetSentiments < ActiveRecord::Migration
  def change
    add_column :tweet_sentiments, :search_term, :string
    add_column :tweet_sentiments, :sentiment_score, :decimal, :precision => 18, :scale => 16 
  end
end
