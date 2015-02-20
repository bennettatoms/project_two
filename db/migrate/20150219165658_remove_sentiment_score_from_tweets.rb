class RemoveSentimentScoreFromTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :sentiment_score, :decimal, :precision => 18, :scale => 16
  end
end
