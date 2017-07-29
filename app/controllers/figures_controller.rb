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

    @figure = Figure.create(:name => params[:figure][:name])

    if params[:title][:name] != ""
      title = Title.create(:name => params[:title][:name])
      @figure.titles << title
    end

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        @figure.titles << Title.find_by(:id => id)
      end
    end

    if params[:landmark][:name] != ""
      landmark = Landmark.create(:name => params[:landmark][:name])
      @figure.landmarks << landmark
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        @figure.landmarks << Landmark.find_by(:id => id)
      end
    end

    @figure.save

    redirect to "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do

    @figure = Figure.find(params[:id])
    @figure.update(:name => params[:figure][:name])

    if params[:title][:name] != ""
      title = Title.find_or_create_by(:name => params[:title][:name])
      @figure.titles << title
    end

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        @figure.titles << Title.find_or_create_by(:id => id)
      end
    end

    if params[:landmark][:name] != ""
      landmark = Landmark.find_or_create_by(:name => params[:landmark][:name])
      @figure.landmarks << landmark
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        @figure.landmarks << Landmark.find_or_create_by(:id => id)
      end
    end

    @figure.save

    redirect to "figures/#{@figure.id}"
  end

end
