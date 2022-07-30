# When I click on that link
# I'm taken to a chef's ingredient index page

# and I can see a unique list of names of all the ingredients that this chef uses

require 'rails_helper'
RSpec.describe "Chef's show page" do 
   it "has the name of the chef and a link to view all ingredients this chef uses" do 
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

      visit "/chefs/#{chef1.id}"

      expect(page).to have_content("Gordon Ramsey")
      expect(page).to have_link("Ramsey Ingredients")
      expect(page).to_not have_content("Martha Stewart")
   end

   it "links to that chef's ingredients index page where I see a list of ingredients chef uses (uniq values only)" do 
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

      visit "/chefs/#{chef1.id}"

      click_link("Ramsey Ingredients")
      expect(current_path).to eq("/chefs/#{chef1.id}/ingredients")
      expect(page).to have_content("Squid")
      expect(page).to have_content("Batter")
      expect(page).to have_content("Lemon")
      expect(page).to have_content("Spinach")
      expect(page).to have_content("Rice")
      expect(page).to_not have_content("Lettuce")
   end
end