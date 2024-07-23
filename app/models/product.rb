class Product < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :order_items
  has_many :reviews, dependent: :destroy

  has_one_attached :image

  validates :title, :description, :price, presence: true
end
