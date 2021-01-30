require './config/environment'

class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #render form to create new recipe; should create and save to database
  get '/recipes/new' do
    erb :new
  end

    #display all recipes in database
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #display a single recipe
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end    


  #renders form to edit a single recipe; should update the entry in database w/changes and redirect to recipe show page
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end


  post '/recipes' do
    @recipe = Recipe.create(params)#name, ingredients, cook_time
    redirect to "/recipes/#{@recipe.id}"
  end


  #delete a recipe from form view
  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end
