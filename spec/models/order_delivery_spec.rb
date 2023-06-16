require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    item = FactoryBot.create(:item)
    buyer = FactoryBot.create(:user)
    @order_delivery = FactoryBot.build(:order_delivery, user_id: buyer.id, item_id: item.id)
  end

  describe "商品購入" do
    context "購入ができる場合" do
      it "すべての情報が入力されていれば購入できる" do
        expect(@order_delivery).to be_valid
      end
      it "buildingは空でも購入できる" do
        @order_delivery.building = ""
        expect(@order_delivery).to be_valid
      end
    end
    context "購入できない場合" do
      it "postal_codeが空では購入できない" do
        @order_delivery.postal_code = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code can't be blank")
      end
      it "postal_codeは半角のハイフンを含めた正しい形式でないと購入できない" do
        @order_delivery.postal_code = "1234567"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "postal_codeのハイフンより前が3桁でないと購入できない" do
        @order_delivery.postal_code = "12-1234"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "postal_codeのハイフンより後が4桁でないと購入できない" do
        @order_delivery.postal_code = "123-456"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it "prefecture_idが1では購入できない" do
        @order_delivery.prefecture_id = "1"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "cityが空では購入できない" do
        @order_delivery.city = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it "addressが空では購入できない" do
        @order_delivery.address = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Address can't be blank")
      end
      it "phoneが空では購入できない" do
        @order_delivery.phone = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone can't be blank")
      end
      it "phoneは半角数字でないと購入できない" do
        @order_delivery.phone = "１２３４５６７８９０"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone is invalid. Input only number")
      end
      it "phoneは9桁以下だと購入できない" do
        @order_delivery.phone = "123456"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone is too short")
      end
      it "phoneは12桁以上だと購入できない" do
        @order_delivery.phone = "123456789012"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Phone is too short")
      end
      it "購入品が紐づいていないと購入できない" do
        @order_delivery.user = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it "購入者が紐づいていないと購入できない" do
        @order_delivery.item = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では購入できない" do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end