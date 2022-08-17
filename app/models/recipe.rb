class Recipe < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :people, presence: true
end
