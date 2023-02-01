class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_sales_status
  belongs_to :item_shipping_fee_status
  belongs_to :item_prefecture
  belongs_to :item_scheduled_delivery
  has_one_attached :image

  validates :item_name, presence: true
  validates :item_info, presence: true
  validates :image, presence: true
  validates :item_category_id, numericality: { other_than: 1 }
  validates :item_sales_status_id, numericality: { other_than: 1 }
  validates :item_shipping_fee_status_id, numericality: { other_than: 1 }
  validates :item_prefecture_id, numericality: { other_than: 1 }
  validates :item_scheduled_delivery_id, numericality: { other_than: 1 }

  validates :item_price, presence: true,
                         format: { with: /\A[0-9]+\z/ }, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                         numericality: { only_integer: true }
end
