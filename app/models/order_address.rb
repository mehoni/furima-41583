class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :shipping_origin_id, :city, :street_address, :building_name, :phone_number, :order, :user_id,
                :item_id, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end
  validates :shipping_origin_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create(price: Item.find(item_id).price, user_id: user_id)
    Address.create(postal_code: postal_code, shipping_origin_id: shipping_origin_id, city: city, street_address: street_address,
                   building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
