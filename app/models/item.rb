class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image

  belongs_to :category
  belongs_to :condition, class_name: 'Condition', foreign_key: 'condition_id'
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  validates :image, presence: true
  validates :name, presence: true
  validates :info, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true, message: 'is not a number' }

  validates :category_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_fee_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_day_id, numericality: { other_than: 0, message: "can't be blank" }
end
