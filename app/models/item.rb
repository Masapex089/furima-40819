class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    belongs_to :item_status # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    belongs_to :delivery_fee # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    belongs_to :prefecture # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    belongs_to :delivery_day # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency

    belongs_to :user # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency
    has_one_attached :image # rubocop:disable Layout/IndentationWidth,Layout/IndentationConsistency

  # 空の投稿を保存できないようにする
  validates :name, :explanation, :price, :category, :price, presence: true

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_fee_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_day_id, numericality: { other_than: 1, message: "can't be blank" }
end
