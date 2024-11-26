class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(Item_params)
    redirect_to '/'
  end

  private

  def Item_params
    params.require(:item).permit(:name, :image, :text)
  end
end
