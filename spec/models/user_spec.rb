require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { User.new(name: 'Bennett Adams', email: 'bennettadams46@gmail.com', password: 'icu812', password_confirmation: 'icu812') }

  subject { user } 

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid } 

  describe 'validations' do
    describe 'name' do 
      context 'not present' do 
        before { user.name = nil }
        it { should_not be_valid }
      end

      context 'is too short' do 
        before { user.name = 'a' * 2 }
        it { should_not be_valid }
      end

      context 'is too long' do 
        before { user.name = 'a' * 256 }
        it { should_not be_valid }
      end
    end

    describe 'email' do 
      context 'not present' do 
        it 'is invalid' do 
          user.email = ''
          expect(user).to_not be_valid
        end
      end

      context 'is too long' do 
        before { user.email = 'a' * 256 }
        it { should_not be_valid }
      end
     
      context 'valid format' do 
        it 'is valid' do 
          valid_addresses = %w{ user@foo.COM A_U-SER@f.b.org 
                                first.last@foo.jp a+b@baz.cn
                                a@b.co }
          valid_addresses.each do |add|
            user.email = add
            expect(user).to be_valid
          end
        end
      end

      context 'invalid format' do 
        it 'is invalid' do 
          invalid_addresses = %w{ user@foo,COM A_U-SER_at_f.b.org 
                                first.last@fo_o.jp a+b@ba+z.cn 
                                a@b..co }
          invalid_addresses.each do |add|
            user.email = add
            expect(user).to_not be_valid
          end
        end
      end

      context 'not unique' do 
        before do 
          user_with_same_email = user.dup
          user_with_same_email.save
          it { should_not be_valid }
        end
      end

      context 'mixed case' do 
        it 'is saved as lowercase' do 
          mixed_case_email = 'bENneTtadAMs46@GMaiL.com'
          user.email = mixed_case_email
          user.save

          expect(user.reload.email).to eq(mixed_case_email.downcase)
        end
      end
    end
  end
end
