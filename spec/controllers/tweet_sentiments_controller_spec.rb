require 'rails_helper'

RSpec.describe TweetSentimentsController, :type => :controller do
  let(:tweet_sentiment1) { TweetSentiment.create(search_term: "Molly Ringwald", 
                                                 sentiment_score: 4.3) }
  let(:tweet_sentiment2) { TweetSentiment.create(search_term: "Abe Vigoda", 
                                                 sentiment_score: -8.3) }
  describe 'GET #index' do
    it 'renders index' do # loads the page
      get :index
      expect(response).to render_template(:index)
    end

    it 'populate an array of tweet sentiments' do
      get :index
      expect(assigns(:tweet_sentiments)).to eq([tweet_sentiment1, tweet_sentiment2])
    end
  end

  describe 'GET #show' do
    it 'renders show' do
      get :show, id: tweet_sentiment1.id
      expect(response).to render_template(:show)
    end

    it 'assigns correct tweet sentiment' do
      get :show, id: tweet_sentiment1.id
      expect(assigns(:tweet_sentiment)).to eq(tweet_sentiment1)
    end
  end

   describe 'POST #create' do
    context 'valid attributes' do
      let(:valid_attributes) { { search_term: "Abe Vigoda", 
                                 sentiment_score: -8.3 } }
      it 'create new tweet sentiment' do
        expect{
          post :create, tweet_sentiment: valid_attributes
        }.to change(TweetSentiment, :count).by(1)
      end

      it 'redirects to current user page' do
        post :create, tweet_sentiment: valid_attributes
        expect(response).to redirect_to(user_path(current_user))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes requested tweet sentiment' do
      tweet_sentiment_to_remove = TweetSentiment.create(search_term: 
                                    "Molly Ringwald", sentiment_score: 4.3)
      expect{
        delete :destroy, id: tweet_sentiment_to_remove.id
      }.to change(TweetSentiment, :count).by(-1)
    end

    it 'redirects to current user page' do
      tweet_sentiment_to_remove = TweetSentiment.create(search_term: 
                                    "Molly Ringwald", sentiment_score: 4.3)
      delete :destroy, id: tweet_sentiment_to_remove.id
      expect(response).to redirect_to(user_path(current_user))
    end
  end
end
