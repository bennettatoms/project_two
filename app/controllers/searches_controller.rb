class SearchesController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, except: [:index, :show]
  before_action :correct_user,   except: [:new, :create, :index, :show]

  def index
    @searches  = current_user.searches
  end

  def show
    @search = current_user.search(search_term)
  end

  def new
    @active = 'items'
    @item   = Item.new
  end

  def create
    # @item = Item.new(item_params)
    @item = current_user.items.new(item_params) # automagically sets user_id: current_user.id
    # if @item is valid, it returns a truthy value
    if @item.save
      flash[:success] = "Item created."
      redirect_to items_path
    else
      render 'new'
    end
  end

  def edit
    @active = 'items'
  end
end
