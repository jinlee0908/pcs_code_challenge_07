require 'sinatra'
require 'data_mapper'
require_relative 'lib/sucker.rb'

enable :sessions

DataMapper.setup(:default, "sqlite3://#{settings.root}/suckers20.sqlite3")

before do
  @heading = 'Born Every Minute'
  @foot = 'Copyright &copy 2014 The Long Con LLC'
end

get '/' do
  erb:index
end

post '/suckers' do
  sucker = Sucker.create(params[:sucker])
  session[:name] = sucker.display_name
  redirect '/thanks'
end

get '/thanks' do
  @name = session[:name]
  erb:thanks
end

get '/suckers' do
  # "Dir is: #{settings.public_folder}"
  @suckers = Sucker.all
  erb:suckers
end

get '/suckers/:id' do
  @sucker = Sucker.get(params[:id].to_i)
  erb:suckers_specific
end
