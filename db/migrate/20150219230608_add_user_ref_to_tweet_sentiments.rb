class AddUserRefToTweetSentiments < ActiveRecord::Migration
  def change
    add_reference :tweet_sentiments, :user, index: true
    add_foreign_key :tweet_sentiments, :users
  end
end
