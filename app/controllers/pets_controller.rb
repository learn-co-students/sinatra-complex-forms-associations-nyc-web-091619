class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      params[:owner_id] = @owner.id
    end
    @pet = Pet.create(name: params["pet_name"], owner_id: params[:owner_id])
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    @owner = @pet.owner
    erb :"/pets/edit"
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name]) unless params[:pet_name].empty?
    unless params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      params[:pet][:owner_id] = @owner.id
    end

    @pet.update(owner_id: params[:pet][:owner_id])
    redirect to "pets/#{@pet.id}"
  end
end