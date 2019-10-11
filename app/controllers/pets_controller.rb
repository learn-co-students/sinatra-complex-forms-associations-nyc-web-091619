class PetsController < ApplicationController

  #Read
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  #Create
  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get ('/pets/:id/edit') {
    @pet = Pet.find_by(id: params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  }

  patch ('/pets/:id') {
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  }
end