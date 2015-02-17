require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  describe 'GET #new' do 
    it 'renders new' do 
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do 
    let(:user) { User.create(name: 'Bennett Adams', 
                             email: 'bennettadams46@gmail.com', 
                             password: 'icu812', 
                             password_confirmation: 'icu812') }

    context 'valid information' do 
      it 'signs in user' do 
        post :create, session: { email: user.email, password: user.password }
        controller.should be_signed_in
      end

      it "redirects to user's profile" do 
        post :create, session: { email: user.email, password: user.password }
        expect(response).to redirect_to(user_path(user))
      end
    end
    context 'invalid information' do 
      it 'does not sign in user' do 
        post :create, session: { email: 'abc' }
        controller.should_not be_signed_in
      end

      it 're-renders new' do 
        post :create, session: { email: 'abc' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do 
    let(:user) { User.create(name: 'Bennett Adams', 
                             email: 'bennettadams46@gmail.com', 
                             password: 'icu812', 
                             password_confirmation: 'icu812') }
    before { sign_in(user, no_capybara: true) }

    it 'destroys requested session' do 
      delete :destroy
      controller.should_not be_signed_in
    end

    it 'redirects to home' do 
      delete :destroy
      controller.should redirect_to(root_url)
    end
  end
end

