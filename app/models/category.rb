class Category < ApplicationRecord
  validates :name, presence: true
  validates :user, presence: true
  belongs_to :user
  has_many :products
end
