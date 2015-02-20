class AddSentimentScoreToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :sentiment_score, :decimal, :precision => 18, :scale => 16
  end
end
