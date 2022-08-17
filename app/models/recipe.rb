class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_products
  has_many :products, through: :recipe_products
  validates :name, presence: true
  validates :people, presence: true
end
