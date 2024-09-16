require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    user_second = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user_second.id)
    @order = FactoryBot.build(:order_address, item_id: item.id, user_id: user.id)
    sleep(1)
  end

  describe '商品購入' do
    context '商品購入ができる' do
      it '全ての項目を入力すると商品を購入できる' do
        expect(@order).to be_valid
      end
      it 'building_nameは入力しなくても購入できる' do
        @order.building_name = nil
        expect(@order).to be_valid
      end
    end
    context '商品購入ができない' do
      it '郵便番号がないと登録できない' do
        @order.post_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号の[-]がないと購入できない' do
        @order.post_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号は「-」の前が3桁でないと購入できない' do
        @order.post_code = '1234-5678'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号は「-」の後は4桁でなければ購入できない' do
        @order.post_code = '123-456'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid')
      end
      it '都道府県を選択しないと購入できない' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include('Prefecture Select')
      end
      it '市区町村を入力しないと購入できない' do
        @order.city = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it '番地を入力しないと購入できない' do
        @order.address = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号を入力しないと購入できない' do
        @order.phone_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁以下だと登録できない' do
        @order.phone_number = '123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと登録できない' do
        @order.phone_number = '123456789123'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
