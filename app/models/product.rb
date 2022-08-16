class Product < ApplicationRecord
  validates :name, presence: true
  validates :category, presence: true
  validates :user, presence: true
  belongs_to :category
  belongs_to :user
end
