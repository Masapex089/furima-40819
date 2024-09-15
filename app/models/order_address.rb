class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :block, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/ } # rubocop:disable Style/RedundantRegexpCharacterClass
    validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id) # rubocop:disable Style/HashSyntax
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, block: block, building_name: building_name, # rubocop:disable Style/HashSyntax
                   phone_number: phone_number, order_id: order.id) # rubocop:disable Style/HashSyntax
  end
end
