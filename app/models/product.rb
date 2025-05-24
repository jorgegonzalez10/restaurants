# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string
#  price       :float
#  stock       :integer
#  status      :boolean
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#  discount    :integer
#  category_id :bigint           not null
#
class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, :description, :price, presence: true
  scope :ordered, -> { order(created_at: :desc) }
  has_one_attached :photo
  has_many :reviews, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_products_by_name_price_or_discount,
    against: [ :name, :price, :discount ],
    using: {
      tsearch: { prefix: true }
    }
end
