class Product < ApplicationRecord
  belongs_to :user
  validates :name, :description, :price, presence: true
  scope :ordered, -> { order(created_at: :desc) }
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_products_by_name_price_or_discount,
    against: [ :name, :price, :discount ],
    using: {
      tsearch: { prefix: true }
    }
end
