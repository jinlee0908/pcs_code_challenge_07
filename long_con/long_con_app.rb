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
  Sucker.create(params[:name], params[:phone], params[:twitter], params[:email])
  session[:name] = params[:name]
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
  @sucker = Sucker.find(params[:id])
  erb:suckers_specific
end
