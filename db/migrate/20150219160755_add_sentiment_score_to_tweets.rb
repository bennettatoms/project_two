class AddSentimentScoreToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :sentiment_score, :decimal, :precision => 18, :scale => 16 
  end
end
