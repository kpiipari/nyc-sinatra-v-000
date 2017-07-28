require 'sinatra/base'
class FiguresController < ApplicationController

  enable :method_override

  get '/figures' do
    "Hello"
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(:name => params[:figure][:name])
    @title = Title.find_or_create_by(:name => params[:figure][:title_ids])
    @landmark = Landmark.find_or_create_by(:name => params[:figure][:landmark_ids])
    @figure.landmarks << @landmark
    @figure.titles << @title
    @figure.save
    redirect to '/figures'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure_title =
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    binding.pry
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    @title = Title.find_or_create_by(:name => params[:figure][:title_ids])
    @new_landmark = params[:landmark][:name]
    @edit_landmark = params[:figure][:landmark_ids]
      if @new_landmark
        @landmark = Landmark.create(:name => params[:landmark][:name])
      elsif @edit_landmark
        @landmark = Landmark.update(:name => params[:figure][:landmark_ids])
      end
    @figure.landmarks << @landmark
    @figure.titles << @title
    @figure.save

    redirect to "figures/#{@figure.id}"
  end

end
