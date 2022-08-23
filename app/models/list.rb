class List < ApplicationRecord
  belongs_to :user
  validates :people, presence: true
  has_many :list_recipes
  has_many :recipes, through: :list_recipes
end
