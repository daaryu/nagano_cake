class Item < ApplicationRecord
  attachment :image

  belongs_to :genre
  has_many :cart_item
  has_many :order_detail
end