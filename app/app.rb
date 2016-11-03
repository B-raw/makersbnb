ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'models/space'
require_relative 'models/request'

class BnB < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :'home'
  end

  get '/home' do
     erb :'register'
  end

  get '/register' do
    erb :'register'
  end

  post '/register' do
    erb :'welcome'
  end

  get '/spaces' do
    @spaces = Space.all
    erb :spaces
  end

  get '/spaces/finalise' do
    @spaces = Space.all
    erb :'spaces/finalise'
  end

  post '/spaces/finalise' do
    session[:name] = @spaces.name
    redirect '/spaces/finalise'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post '/spaces' do
    Space.create(name: params[:name],
                 description: params[:description],
                 price: params[:price],
                 available_from: params[:available_from],
                 available_to: params[:available_to])
    redirect '/spaces'
  end

  get '/spaces/filter_dates' do
    @spaces = Space.search_availability(session[:available_from], session[:available_to])
    erb :spaces
  end

  post '/spaces/filter_dates' do
    session[:available_from] = Date.parse(params[:available_from])
    session[:available_to] = Date.parse(params[:available_to])
    redirect '/spaces/filter_dates'
  end

  get '/spaces/:id' do
    @space = Space.get(params[:id])
    erb :'space_listing'
  end

<<<<<<< HEAD
  post '/spaces/request' do
    Request.create(requested_date: params[:requested_date])
  end

  get '/spaces/request' do

  end
=======
  post '/requests/new' do
    session[:check_in] = params[:check_in]
    session[:check_out] = params[:check_in]
    redirect '/requests'
  end

  get '/requests' do
    erb :requests
  end

  get '/requests/:id' do
    # @request = Request.get(params[:id])
    erb :'request'
>>>>>>> feature_05


  # start the server if ruby file executed directly
  run! if app_file == $0
end
