class Item < ApplicationRecord
  attachment :image

  belongs_to :genres
  has_many :cart_items
  has_many :order_details
end