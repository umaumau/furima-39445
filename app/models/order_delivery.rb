class OrderDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building, :phone, :order_id

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address
    validates :phone, format: {with: /\A[0-9]{10,11}\z/, message: "is invalid."}
  end
  validates :prefecture_id, numericality: {other_than: 1 , message: "can't be blank"} 

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, phone: phone, order_id: order.id)
  end
end