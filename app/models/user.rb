class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :services

  has_many :products
  has_one :cart
  has_many :orders
  has_many :reviews, dependent: :destroy

  enum user_type: { buyer: 0, seller: 1 }

  def buyer?
    user_type == "buyer"
  end

  def seller?
    user_type == "seller"
  end

end
