class OrderDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building, :phone, :order_id, :token, :price

  validates :item_id      , presence: true
  validates :user_id      , presence: true
  validates :postal_code  , presence: true
  validates :postal_code  , format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
  validates :prefecture_id, numericality: {other_than: 1 , message: "can't be blank"} 
  validates :city         , presence: true
  validates :address      , presence: true
  validates :phone        , presence: true
  validates :phone        , length: {minimum: 10, message: "is too short"}
  validates :phone        , numericality: {only_integer: true, message: "is invalid. Input only number"}
  validates :token        , presence: true
  validates :price        , presence: true

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, phone: phone, order_id: order.id)
  end
end