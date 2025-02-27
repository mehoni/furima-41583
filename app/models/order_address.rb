class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :shipping_origin_id, :city, :street_address, :building_name, :phone_number,
                :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid. Phone number should be 10 or 11 digits' }
  end
  validates :shipping_origin_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    item = Item.find_by(id: item_id)
    return false unless item

    order = Order.create(user_id: user_id, item_id: item_id)

    Address.create(postal_code: postal_code, shipping_origin_id: shipping_origin_id, city: city,
                   street_address: street_address, building_name: building_name, phone_number: phone_number,
                   order_id: order.id)
  end
end
