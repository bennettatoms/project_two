class AddTweetsListToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tweets_list, :string, array: true, default: []
    remove_column :tweets, :text, :string
  end
end
