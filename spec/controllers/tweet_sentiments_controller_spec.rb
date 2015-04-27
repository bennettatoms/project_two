require 'rails_helper'

RSpec.describe TweetSentimentsController, :type => :controller do
  let(:user)             { FactoryGirl.create(:user) }
  let(:tweet_sentiment1) { FactoryGirl.create(:tweet_sentiment, user: user) }
  let(:tweet_sentiment2) { FactoryGirl.create(:tweet_sentiment, user: user) }
  before { sign_in user, no_capybara: true }

  describe 'GET #index' do
    it 'renders index' do # loads the page
      get :index
      expect(response).to render_template(:index)
    end

    it 'populate an array of tweet sentiments' do
      get :index
      expect(assigns(:sentiments)).to eq([tweet_sentiment1, tweet_sentiment2])
    end
  end

  describe 'GET #show' do
    it 'renders show' do
      get :show, id: tweet_sentiment1.id
      expect(response).to render_template(:show)
    end

    it 'assigns correct tweet sentiment' do
      get :show, id: tweet_sentiment1.id
      expect(assigns(:sentiment)).to eq(tweet_sentiment1)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user, no_capybara: true }
    
    context 'valid attributes' do
      it 'create new tweet sentiment' do
        expect{
          post :create, tweet_sentiment: FactoryGirl.attributes_for(:tweet_sentiment)
        }.to change(TweetSentiment, :count).by(1)
      end

      it 'redirects to current user page' do
        post :create, tweet_sentiment: FactoryGirl.attributes_for(:tweet_sentiment)
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes requested tweet sentiment' do
      tweet_sentiment_to_remove = FactoryGirl.create(:tweet_sentiment, user: user)

      expect{
        delete :destroy, id: tweet_sentiment_to_remove.id
      }.to change(TweetSentiment, :count).by(-1)
    end

    it 'redirects to current user page' do
      tweet_sentiment_to_remove = FactoryGirl.create(:tweet_sentiment, user: user)

      delete :destroy, id: tweet_sentiment_to_remove.id
      expect(response).to redirect_to(user_path(user))
    end
  end
end
