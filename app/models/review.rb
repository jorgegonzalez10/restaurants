class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :content, :rating, presence: true
end
