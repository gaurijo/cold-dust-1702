class Chef <ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :dish_ingredients, through: :dishes 
  has_many :ingredients, through: :dish_ingredients

  def uniq_ingreds
    # ingredients.uniq.pluck(:name)
    dishes.joins(dish_ingredients: :ingredient).select("ingredients.*").pluck("ingredients.name").uniq
  end
end
