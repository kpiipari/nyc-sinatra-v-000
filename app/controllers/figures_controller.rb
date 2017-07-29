require 'sinatra/base'
class FiguresController < ApplicationController

  enable :method_override

  get '/figures' do
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    new_title = params[:title][:name]
    existing_title = params[:figure][:title_ids]
    new_landmark = params[:landmark][:name]
    edit_landmark = params[:figure][:landmark_ids]

    @figure = Figure.create(:name => params[:figure][:name])

    if new_title != ""
      @title = Title.create(:name => new_title)
    elsif existing_title
      @title = Title.find_by(:id => existing_title)
    end
    @figure.titles << @title

    if new_landmark != ""
      @landmark = Landmark.create(:name => new_landmark)
    elsif edit_landmark
      @landmark = Landmark.find_by(:id => edit_landmark)
    end
    @figure.landmarks << @landmark

    @figure.save

    redirect to "figures/#{@figure.id}"
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
    new_title = params[:title][:name]
    existing_title = params[:figure][:title_ids]
    new_landmark = params[:landmark][:name]
    edit_landmark = params[:figure][:landmark_ids]

    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]

    if new_title != ""
      @title = Title.create(:name => new_title)
    elsif existing_title
      @title = Title.find_by(:id => existing_title)
    end
    @figure.titles << @title

    if new_landmark != ""
      @landmark = Landmark.create(:name => new_landmark)
    elsif edit_landmark
      @landmark = Landmark.update(:id => edit_landmark)
    end
    @figure.landmarks << @landmark
    @figure.titles << @title
    @figure.save

    redirect to "/figures"
  end

end
