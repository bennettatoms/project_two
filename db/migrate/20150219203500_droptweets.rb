class Droptweets < ActiveRecord::Migration
  drop_table :tweets
  drop_table :searches
  def change
  end
end
