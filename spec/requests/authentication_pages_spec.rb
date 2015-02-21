require 'rails_helper'

describe 'Authentication' do 
  subject { page }

  describe 'sign in page' do 
    before { visit signin_path }

    it { should have_title('Sign In') }
    it { should have_content('Sign In') }

    describe 'sign in process' do 
      let(:submit) { 'Sign In' }
      let(:user) { User.create(name: 'Bennett Adams', 
                               email: 'bennettadams46@gmail.com', 
                               password: 'icu812', 
                               password_confirmation: 'icu812') }
      context 'valid information' do 
        before { sign_in user }

        it { should have_title(user.name) }
      end

      context 'invalid information' do 
      end
    end
  end
end
