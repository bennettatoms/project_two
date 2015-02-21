require 'rails_helper'

RSpec.describe TweetSentiment, :type => :model do
  let(:tweet_sentiment) { TweetSentiment.new(search_term: "Abe Vigoda", 
                                             sentiment_score: 1.7) }
  
  it { should respond_to(:search_term) }
  it { should respond_to(:sentiment_score) }

  it { should be_valid }

  describe 'validations' do
    describe 'search_term' do
      context 'not present' do
        before { tweet_sentiment.search_term = nil }
        it { should_not be_valid }
      end

      context 'too long' do
        before { tweet_sentiment.search_term = 'a' * 256 }
        it { should_not be_valid }
      end
    end

    describe 'sentiment score' do
      context 'not present' do
        before { tweet_sentiment.sentiment_score = nil }
        it { should_not be_valid }
      end
    end
  end
end

