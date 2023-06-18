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
        expect(@order_delivery.errors.full_messages).to include("郵便番号を入力してください")
      end
      it "postal_codeは半角のハイフンを含めた正しい形式でないと購入できない" do
        @order_delivery.postal_code = "1234567"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号は正しい形式で入力してください (例：123-4567)")
      end
      it "postal_codeのハイフンより前が3桁でないと購入できない" do
        @order_delivery.postal_code = "12-1234"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号は正しい形式で入力してください (例：123-4567)")
      end
      it "postal_codeのハイフンより後が4桁でないと購入できない" do
        @order_delivery.postal_code = "123-456"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("郵便番号は正しい形式で入力してください (例：123-4567)")
      end
      it "prefecture_idが1では購入できない" do
        @order_delivery.prefecture_id = "1"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("都道府県を入力してください")
      end
      it "cityが空では購入できない" do
        @order_delivery.city = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("市区町村を入力してください")
      end
      it "addressが空では購入できない" do
        @order_delivery.address = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("番地を入力してください")
      end
      it "phoneが空では購入できない" do
        @order_delivery.phone = ""
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号を入力してください")
      end
      it "phoneは半角数字でないと購入できない" do
        @order_delivery.phone = "１２３４５６７８９０"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号は半角数字で入力してください")
      end
      it "phoneは9桁以下だと購入できない" do
        @order_delivery.phone = "123456"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号は10~11桁で入力してください")
      end
      it "phoneは12桁以上だと購入できない" do
        @order_delivery.phone = "123456789012"
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("電話番号は10~11桁で入力してください")
      end
      it "購入者が紐づいていないと購入できない" do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("購入者を入力してください")
      end
      it "商品が紐づいていないと購入できない" do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("商品を入力してください")
      end
      it "tokenが空では購入できない" do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
    end
  end
end