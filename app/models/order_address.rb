class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address,
                :building_name, :phone_number,
                :user_id, :item_id, :token

  validates :token, presence: true
  validates :postal_code, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :phone_number, length: { minimum: 10, maximum: 11, too_short: 'is too short' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }

  def save
    Order.create(user_id: user_id, item_id: item_id)
  end
end