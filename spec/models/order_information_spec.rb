require 'rails_helper'

RSpec.describe OrderInformation, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_information = FactoryBot.build(:order_information, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品購入できる場合' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@order_information).to be_valid
      end
    end
    context '商品購入できない場合' do
      it '郵便番号が空では保存できない' do
        @order_information.postal_code = ''
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Postal code can't be blank")
      end
      it '都道府県が空では保存できない' do
        @order_information.item_prefecture_id = 1
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include('Item prefecture must be other than 1')
      end
      it '番地が空では保存できない' do
        @order_information.addresses = ''
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号が空では保存できない' do
        @order_information.phone_number = ''
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'tokenが空では保存できない' do
        @order_information.token = ''
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号が全角では保存できない' do
        @order_information.postal_code = 'ああああ'
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号にハイフンがないと保存できない' do
        @order_information.postal_code = '1234567'
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include('Postal code is invalid')
      end
      it '電話番号が全角では保存できない' do
        @order_information.phone_number = 'ああああ'
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁以下では保存できない' do
        @order_information.phone_number = '090123456'
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上では保存できない' do
        @order_information.phone_number = '090123456789'
        @order_information.valid?
        expect(@order_information.errors.full_messages)
      end
      it 'userが紐付いていないと保存できない' do
        @order_information.user_id = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できない' do
        @order_information.item_id = nil
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
