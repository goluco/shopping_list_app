class RecipeProduct < ApplicationRecord
  belongs_to :product
  belongs_to :recipe
  validates :quantity, presence: true
end
