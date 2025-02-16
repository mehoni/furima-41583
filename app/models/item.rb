class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_origin
  belongs_to_active_hash :shipping_date_estimate

  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :image, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_cost_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_origin_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_date_estimate_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true, numericality: { only_integer: true, message: 'は半角数字のみで入力してください' }
  validates :price, numericality: { greater_than_or_equal_to: 300, message: 'must be greater than or equal to 300' }
  validates :price, numericality: { less_than_or_equal_to: 9_999_999, message: 'must be less than or equal to 9999999' }
end
