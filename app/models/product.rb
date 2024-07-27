class Product < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_one_attached :image

  validates :title, :description, :price, presence: true
end
