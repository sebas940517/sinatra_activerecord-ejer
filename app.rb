require_relative "config/application"
require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

get '/' do
  erb :landing
end

get '/restaurants' do
  @restaurants = Restaurant.all
  erb :index
end

get '/restaurants/new' do
  @restaurant = Restaurant.new
  erb :new
end

get '/restaurant/:id/edit' do
  @restaurant = Restaurant.find(params[:id])
  erb :edit
end

patch '/restaurant/:id' do
  @restaurant = Restaurant.find(params[:id])
  @restaurant.update(name: params[:name], city: params[:city], address: params[:address], image_url: params[:image_url])
  redirect to "/restaurant/#{@restaurant.id}"
end

delete '/restaurant' do
  @restaurant = Restaurant.find(params[:id])
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find(params[:id])
  erb :show
end

post '/restaurants' do
  name = params[:name]
  city = params[:city]
  address = params[:address]
  image_url = params[:image_url]
  Restaurant.create(name: name, city: city, address: address, image_url: image_url)
  redirect to '/restaurants'
end
