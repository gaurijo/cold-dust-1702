require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many(:dish_ingredients)}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "model methods" do 
    it "calorie_count" do 
        chef1 = Chef.create!(name: "Gordon Ramsey")
        calamari = chef1.dishes.create!(name: "Calamari", description: "Fried comfort food")
        squid = Ingredient.create!(name: "Squid", calories: 300)
        batter = Ingredient.create!(name: "Batter", calories: 200)
        lemon = Ingredient.create!(name: "Lemon", calories: 10)

        dish_ingr1 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: squid.id)
        dish_ingr2 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: batter.id)
        dish_ingr3 = DishIngredient.create!(dish_id: calamari.id, ingredient_id: lemon.id)

        expect(calamari.calorie_count).to eq(510)
    end
  end
end
