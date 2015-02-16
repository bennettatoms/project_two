require 'rails_helper'

describe 'user pages' do 
  subject { page }

  describe 'index' do 
    User.destroy_all 
    let(:user1) { User.create(name: 'Bennett Adams', 
                              email: 'bennettadams46@gmail.com', 
                              password: 'icu812', 
                              password_confirmation: 'icu812') }
    let(:user2) { User.create(name: 'Sam Iam', 
                              email: 'samiam@gmail.com', 
                              password: 'foobar', 
                              password_confirmation: 'foobar') }

    before { visit users_path }
    it { should have_title('Users') }
    it { should have_selector('h1', text: 'Users') }

    it 'lists each user' do 
      User.all.each do |user| 
        expect(page).to have_selector('li', text: user.id)
      end
    end

    describe 'delete links' do 
      let!(:user1) { User.create(name: 'Bennett Adams', 
                                email: 'bennettadams46@gmail.com', 
                                password: 'icu812', 
                                password_confirmation: 'icu812') }
      let!(:user2) { User.create(name: 'Sam Iam', 
                                email: 'samiam@gmail.com', 
                                password: 'foobar', 
                                password_confirmation: 'foobar') }
      before { visit users_path }
      it { should have_link('delete', href: user_path(user.first)) }

      describe 'after clicking delete' do 
        before { click_link('delete', match: :first) }
        it { should_not have_content('Bennett Adams') }
      end
    end
  end

  describe 'show' do 
    let(:user) { User.create(name: 'Bennett Adams', 
                             email: 'bennettadams46@gmail.com', 
                             password: 'icu812', 
                             password_confirmation: 'icu812') }
    before { visit user_path(user.id) }

    it { should have_title(user.name) }
    it { should have_selector('h1', text: user.name) }
  end

  describe 'new user page' do 
    before { visit signup_path } 

    it { should have_title('Sign Up') }
    it { should have_selector('h1', 'Sign Up') }

    describe 'create user' do 
      let(:submit) { 'Save' }

      context 'valid information' do 
        before do 
          fill_in 'Name', with: 'Bennett Adams'
          fill_in 'Email', with: 'bennettadams46@gmail.com'
          fill_in 'Password', with: 'icu812'
          fill_in 'Confirm password', with: 'icu812'
        end

        it 'creates user' do 
          expect { click_button submit }.to change(User, :count).by(1)
        end

        describe 'after saving' do 
          before { click_button submit }

          it { should have_title('Bennett Adams') }
        end
      end

      context 'invalid information' do 
        it 'does not create user' do 
          expect { click_button submit }.not_to change(User, :count)
        end

        describe 'after submission' do 
          before { click_button submit }

          it { should have_title('Sign Up') }
          it { should have_content('error') }
        end
      end
    end
  end

  describe 'edit user page' do 
    let(:user_to_edit) { User.create(name: 'Bennett Adams', 
                                     email: 'bennettadams46@gmail.com', 
                                     password: 'icu812', 
                                     password_confirmation: 'icu812') }
    before { visit edit_user_path(user_to_edit.id) }

    it { should have_title('Edit Profile') }
    it { should have_selector('h1', text: 'Edit Profile') }

    describe 'update user' do 
      let(:submit) { 'Save' }

      context 'valid information' do 

        before do 
          fill_in 'Name', with: 'The One and Only'
          click_button submit
        end

        describe 'after saving changes' do 
          it { should have_title('The One and Only') }
          specify { expect(user_to_edit.reload.name).to eq('The One and Only') }
        end
      end

      context 'invalid information' do 
        before do 
          fill_in 'Name', with: '' 
          click_button submit
        end

        describe 'after submission' do 
          it { should have_title('Edit Profile') }
          it { should have_content('error') }
        end
      end
    end
  end
end





