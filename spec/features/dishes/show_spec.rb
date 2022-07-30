require 'rails_helper'
RSpec.describe "Dish show page" do 
   it "has the dish's name and description" do
      chef1 = Chef.create!(name: "Gordon Ramsey")

      calamari = chef1.dishes.create!(name: "Calamari", description: "Fried comfort food")
      paneer = chef1.dishes.create!(name: "Saag Paneer", description: "Cream spinach with spicy cottage cheese")
      paella = chef1.dishes.create!(name: "Paella", description: "Spanish rice with shellfish and sausage")

      squid = Ingredient.create!(name: "Squid", calories: 300)
      batter = Ingredient.create!(name: "Batter", calories: 200)
      lemon = Ingredient.create!(name: "Lemon", calories: 10)
      spinach = Ingredient.create!(name: "Spinach", calories: 5)

      dish_ingr1 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: squid.id)
      dish_ingr2 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: batter.id)
      dish_ingr3 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: lemon.id)
      dish_ingr4 = DishIngredient.create!(dish_id: paneer.id, ingredient_id: spinach.id)

      visit "/dishes/#{calamari.id}"

      expect(page).to have_content("Calamari")
      expect(page).to_not have_content("Paella")
   end

   it "has a list of ingredients for that dish and the chef's name" do
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

      dish_ingr1 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: squid.id)
      dish_ingr2 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: batter.id)
      dish_ingr3 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: lemon.id)
      dish_ingr4 = DishIngredient.create!(dish_id: paneer.id, ingredient_id: spinach.id)

      visit "/dishes/#{calamari.id}"

      expect(page).to have_content("Squid")
      expect(page).to have_content("Batter")
      expect(page).to have_content("Lemon")
      expect(page).to have_content("Gordon Ramsey")
      expect(page).to_not have_content("Spinach")
      expect(page).to_not have_content("Martha Stewart")
   end

   it "has a total calorie count for that dish" do 
      chef1 = Chef.create!(name: "Gordon Ramsey")

      calamari = chef1.dishes.create!(name: "Calamari", description: "Fried comfort food")
      
      squid = Ingredient.create!(name: "Squid", calories: 300)
      batter = Ingredient.create!(name: "Batter", calories: 200)
      lemon = Ingredient.create!(name: "Lemon", calories: 10)

      dish_ingr1 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: squid.id)
      dish_ingr2 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: batter.id)
      dish_ingr3 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: lemon.id)
   
      visit "/dishes/#{calamari.id}"

      expect(page).to have_content("510")
   end
end
