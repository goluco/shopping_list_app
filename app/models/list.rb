class List < ApplicationRecord
  belongs_to :user
  validates :people, presence: true
end
