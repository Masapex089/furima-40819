class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    belongs_to :item_status # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    belongs_to :delivery_fee # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    belongs_to :prefecture # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    belongs_to :delivery_day # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency

    belongs_to :user # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    has_one_attached :image # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency

  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :explanation, presence: true, length: { maximum: 1000 }
  validates :category_id, numericality: { other_than: 1, message: 'Select' }
  validates :item_status_id, numericality: { other_than: 1, message: 'Select' }
  validates :delivery_fee_id, numericality: { other_than: 1, message: 'Select' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
  validates :delivery_day_id, numericality: { other_than: 1, message: 'Select' }
  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }, numericality: { greater_than: 299, less_than: 10000000 } # rubocop:disable Style/NumericLiterals
end
