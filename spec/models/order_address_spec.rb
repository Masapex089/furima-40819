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
      it 'post_codeがないと登録できない' do
        @order.post_code = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeの[-]がないと購入できない' do
        @order.post_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid')
      end
      it 'post_codeは「-」の前が3桁でないと購入できない' do
        @order.post_code = '1234-5678'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid')
      end
      it 'post_codeは「-」の後は4桁でなければ購入できない' do
        @order.post_code = '123-456'
        @order.valid?
        expect(@order.errors.full_messages).to include('Post code is invalid')
      end
      it 'prefectureを選択しないと購入できない' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include('Prefecture Select')
      end
      it 'cityを入力しないと購入できない' do
        @order.city = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it 'blockを入力しないと購入できない' do
        @order.block = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Block can't be blank")
      end
      it 'phone_numberを入力しないと購入できない' do
        @order.phone_number = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下だと登録できない' do
        @order.phone_number = '123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが12桁以上だと登録できない' do
        @order.phone_number = '123456789123'
        @order.valid?
        expect(@order.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
