class CreateTweetSentiments < ActiveRecord::Migration
  def change
    create_table :tweet_sentiments do |t|

      t.timestamps null: false
    end
  end
end
