class Product < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :name, :description, :price, presence: true
  scope :ordered, -> {order(created_at: :desc)}
  has_one_attached :photo
end
