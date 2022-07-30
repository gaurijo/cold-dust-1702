require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end

  describe "model methods" do 
    it "has a uniq list of ingredients" do 
      chef1 = Chef.create!(name: "Gordon Ramsey")
      chef2 = Chef.create!(name: "Martha Stewart")

      calamari = chef1.dishes.create!(name: "Calamari", description: "Fried comfort food")
      paneer = chef1.dishes.create!(name: "Saag Paneer", description: "Cream spinach with spicy cottage cheese")
      paella = chef1.dishes.create!(name: "Paella", description: "Spanish rice with shellfish and sausage")
      salad = chef2.dishes.create!(name: "Spring Salad", description: "Sad")

      squid = Ingredient.create!(name: "Squid", calories: 300)
      batter = Ingredient.create!(name: "Batter", calories: 200)
      lemon = Ingredient.create!(name: "Lemon", calories: 10)
      spinach = Ingredient.create!(name: "Spinach", calories: 5)
      rice = Ingredient.create!(name: "Rice", calories: 50)
      lettuce = Ingredient.create!(name: "Lettuce", calories: 5)

      dish_ingr1 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: squid.id)
      dish_ingr2 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: batter.id)
      dish_ingr3 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: lemon.id)
      dish_ingr4 = DishIngredient.create!(dish_id: paneer.id, ingredient_id: spinach.id)
      dish_ingr5 = DishIngredient.create!(dish_id: paella.id, ingredient_id: squid.id)
      dish_ingr5 = DishIngredient.create!(dish_id: paella.id, ingredient_id: rice.id)
      dish_ingr6 = DishIngredient.create!(dish_id: paneer.id, ingredient_id: rice.id)
      dish_ingr6 = DishIngredient.create!(dish_id: salad.id, ingredient_id: lettuce.id)

      expect(chef1.uniq_ingreds).to eq([squid.name, batter.name, lemon.name, spinach.name, rice.name])
    end
  end
end
