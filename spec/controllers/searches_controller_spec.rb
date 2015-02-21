require 'rails_helper'

RSpec.describe SearchesController, :type => :controller do
  describe 'GET #new' do 
      it 'renders new' do 
        get :new
        expect(response).to render_template(:new)
      end
    end

  describe 'GET #index' do 
    it 'renders index' do 
      get :index
      expect(response).to render_template(:index)
    end
  end
end
