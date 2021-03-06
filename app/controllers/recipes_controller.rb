class RecipesController < ApplicationController
	before_action :find_recipe, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	
	def index
		@recipe = Recipe.all.order("created_at DESC")
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, notice: 'Succesfully created new recipe'
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @recipe.update(recipe_params)
			redirect_to @recipe
		else
			render 'edit'
		end
	end

	def destroy
		@recipe.destroy
		redirect_to root_path, notice: 'Succesfully deleted recipe'
	end

	def show
	end

	def new
		@recipe = current_user.recipes.build
	end

	private

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end

	def recipe_params
		params.require(:recipe).permit(:id, :title, :description, :image, directions_attributes: [:id, :step, :_destroy], ingredients_attributes: [:id, :name, :_destroy])
	end

end
