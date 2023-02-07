class OrderInformation 
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :item_prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :city
    validates :addresses
    validates :phone_number, format: {with: /\A[0-9]\d{10,11}\z/}
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  end
    validates :item_prefecture_id, numericality: { other_than: 1 }
  

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    OrderAddress.create(postal_code: postal_code, item_prefecture_id: item_prefecture_id, city: city, addresses: addresses, building: building,  phone_number: phone_number, order_id: order.id)
  end

end

