class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params.merge(user_id: current_user.id))
    if @item.save
      redirect_to items_path(@item)
    else
      Rails.logger.info @item.errors.full_messages # エラー内容をターミナルに出力
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :condition_id, :shipping_cost_id,
                                 :shipping_origin_id, :shipping_date_estimate_id, :price, :user_id)
  end
end
