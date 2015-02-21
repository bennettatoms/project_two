require 'rails_helper'

describe 'static pages' do
  subject { page }

  describe 'home page' do
    before { visit root_path }

    it { should have_title('TweetHeart') }
    it { should have_selector('h1', text: '!') }
  end

  describe 'about page' do
    before { visit about_path }
    
    it { should have_title('TweetHeart')}
    it { should have_selector('h1', text: 'About TweetHeart') }
  end
end