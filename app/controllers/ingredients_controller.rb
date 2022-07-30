class IngredientsController < ApplicationController
   def index 
      @chef = Chef.find(params[:id])
      @ingredients = @chef.uniq_ingreds
   end
end