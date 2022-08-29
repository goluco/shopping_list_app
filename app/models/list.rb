class List < ApplicationRecord
  belongs_to :user
  validates :people, presence: true
  has_many :list_recipes
  has_many :recipes, through: :list_recipes

  def final_list
    updated_list = []
    name_list = []
    recipes.each do |recipe|
      recipe.recipe_products.each do |recipe_product|
        item = { name: recipe_product.product.name.to_s, quantity: (recipe_product.quantity.to_i) * (people / recipe.people), category: recipe_product.product.category }
        if name_list.include?(item[:name])
          temp_array = updated_list.select { |element| element[:name] == item[:name] }
          other_item = temp_array.last
          name = item[:name]
          quantity = (other_item[:quantity] + item[:quantity])
          category = other_item[:category]
          new_item = { name: name, quantity: quantity, category: category }
          updated_list.delete_at(updated_list.index(other_item))
          updated_list << new_item
        else
          updated_list << item
          name_list << item[:name]
        end
      end
    end
    updated_list
  end
end
