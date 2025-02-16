class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_gon_public_key, only: [:index]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_seller, only: [:index, :create]
  before_action :redirect_if_sold_out, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
      pay_item
      if @order_address.save
        redirect_to root_path
      else
        Rails.logger.error "Failed to save order_address: #{@order_address.errors.full_messages.join(', ')}"
        flash[:alert] = '購入処理に失敗しました。入力内容を確認してください。'
        render 'index', status: :unprocessable_entity
      end
    else
      Rails.logger.error "Validation failed: #{@order_address.errors.full_messages.join(', ')}"
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
