class Item < ApplicationRecord
  validates :image        , presence: true
  validates :name         , presence: true
  validates :content      , presence: true
  validates :category_id  , numericality: { other_than: 1 , message: "can't be blank"} 
  validates :condition_id , numericality: { other_than: 1 , message: "can't be blank"} 
  validates :postage_id   , numericality: { other_than: 1 , message: "can't be blank"} 
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :duration_id  , numericality: { other_than: 1 , message: "can't be blank"} 
  validates :price        , presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }, format: { with: /\A\d+\z/ }

  has_one_attached :image
  belongs_to :user
end
