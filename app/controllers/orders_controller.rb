class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_gon_public_key, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_seller, only: [:index, :create]
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid? && @order_address.save
      pay_item
      redirect_to root_path
    else
      flash.now[:alert] = '入力内容に不備があります。再度確認してください。'
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_gon_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :shipping_origin_id, :city, :street_address, :building_name,
                                          :phone_number).merge(user_id: current_user.id, token: params[:token], item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_if_seller
    redirect_to root_path if current_user&.id == @item.user_id
  end

  def redirect_if_sold_out
    redirect_to root_path if @item.order.present?
  end
end
