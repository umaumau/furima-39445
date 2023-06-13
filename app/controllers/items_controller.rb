class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :item_find, only: [:show, :edit, :update, :move_to_index]
  before_action :move_to_index, only: :edit

  def index
    @item = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :content, :category_id, :condition_id, :postage_id, :prefecture_id, :duration_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless current_user.id == @item.user.id
      redirect_to root_path
    end
  end

  def item_find
    @item = Item.find(params[:id])
  end
  
end
