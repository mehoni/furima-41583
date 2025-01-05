class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:edit, :update]
  before_action :redirect_unless_owner, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params.merge(user_id: current_user.id))
    if @item.save
      redirect_to items_path(@item)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_owner
    return if current_user.id == @item.user_id

    redirect_to root_path
  end

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :condition_id, :shipping_cost_id,
                                 :shipping_origin_id, :shipping_date_estimate_id, :price, :user_id)
  end
end
