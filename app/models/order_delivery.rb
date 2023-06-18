class OrderDelivery
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building, :phone, :token

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :postal_code  , format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は正しい形式で入力してください (例：123-4567)"}
    validates :prefecture_id, numericality: {other_than: 1 , message: "を入力してください"} 
    validates :city
    validates :address
    validates :phone        , length: {minimum: 10, maximum: 11, message: "は10~11桁で入力してください"}, numericality: {only_integer: true, message: "は半角数字で入力してください"}
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Delivery.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone: phone, order_id: order.id)
  end
end