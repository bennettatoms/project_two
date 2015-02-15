require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe 'GET #new' do 
    it 'renders new' do 
      get :new
      expect(response).to render_template(:new) 
    end

    it 'assigns a new user' do 
      get :new 
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do 
    context 'valid attributes' do 
      let(:valid_attributes) { { name: 'Bennett Adams', 
                                 email: 'bennettadams46@gmail.com', 
                                 password: 'icu812', 
                                 password_confirmation: 'icu812' } }

      it 'create new user' do 
        expect{
          post :create, user: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'redirects to users#show' do 
        post :create, user: valid_attributes
        expect(response).to redirect_to(user_path(User.last.id))
      end
    end

    context 'invalid attributes' do 
      let(:invalid_attributes) { { name: '' } }

      it 'does not create new user' do 
        expect{
          post :create, user: invalid_attributes 
        }.to_not change(User, :count)
      end

      it 're-renders new' do 
        post :create, user: invalid_attributes
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do 
    let(:user) { User.create(name: 'Bennett Adams', 
                             email: 'bennettadams46@gmail.com', 
                             password: 'icu812', 
                             password_confirmation: 'icu812') }
    it 'renders show' do 
      get :show, id: user.id
      expect(response).to render_template(:show)
    end

    it 'assigns the correct user' do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'GET #index' do 
    let(:user1) { User.create(name: 'Bennett Adams', 
                              email: 'bennettadams46@gmail.com', 
                              password: 'icu812', 
                              password_confirmation: 'icu812') }
    let(:user2) { User.create(name: 'Sam Iam', 
                              email: 'samiam@gmail.com', 
                              password: 'foobar', 
                              password_confirmation: 'foobar') }
    it 'renders index' do 
      get :index
      expect(response).to render_template(:index)
    end

    it 'populates an array of users' do 
      get :index
      expect(assigns(:users)).to eq([user1, user2])
    end
  end

  describe 'GET #edit' do 
    let(:user_to_edit) { User.create(name: 'Bennett Adams', 
                                     email: 'bennettadams46@gmail.com', 
                                     password: 'icu812', 
                                     password_confirmation: 'icu812') }
    it 'renders edit' do 
      get :edit, id: user_to_edit.id
      expect(response).to render_template(:edit)
    end

    it 'assigns correct user' do 
      get :edit, id: user_to_edit.id
      expect(assigns(:user)).to eq(user_to_edit)
    end
  end

  describe 'PATCH #update' do 
    let(:user_to_edit) { User.create(name: 'Bennett Adams', 
                                     email: 'bennettadams46@gmail.com', 
                                     password: 'icu812', 
                                     password_confirmation: 'icu812') }
    context 'valid attributes' do 
      it 'updates user' do 
        patch :update, id: user_to_edit.id, user: { name: 'The One and Only' }
        user_to_edit.reload
        expect(user_to_edit.name).to eq('The One and Only')
      end

      it 'redirects to users#show' do 
        patch :update, id: user_to_edit.id, user: { name: 'The One and Only' }
        expect(response).to redirect_to(user_path(user_to_edit.id))
      end
    end

    context 'invalid attributes' do 
      it 'does not update user' do 
        patch :update, id: user_to_edit.id, user: { name: '' }
        user_to_edit.reload
        expect(user_to_edit.name).to eq('Bennett Adams')
      end

      it 're-renders edit' do 
        patch :update, id: user_to_edit.id, user: { name: '' }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do 
    it 'deletes requested user' do 
      user_to_remove = User.create(name: 'Bennett Adams', 
                                   email: 'bennettadams46@gmail.com', 
                                   password: 'icu812', 
                                   password_confirmation: 'icu812')
      expect{
        delete :destroy, id: user_to_remove.id
      }.to change(User, :count).by(-1)
    end

    it 'redirects to index' do 
      user_to_remove = User.create(name: 'Bennett Adams', 
                                   email: 'bennettadams46@gmail.com', 
                                   password: 'icu812', 
                                   password_confirmation: 'icu812')
      delete :destroy, id: user_to_remove.id
      expect(response).to redirect_to(users_path)
    end
  end
end
