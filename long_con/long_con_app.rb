require 'sinatra'
require 'data_mapper'
require_relative 'lib/parse.rb'

enable :sessions

before do
  @heading = 'Born Every Minute'
  @foot = 'Copyright &copy 2014 The Long Con LLC'
  @data_path = "#{settings.public_folder}/people20.sqlite3"
end

get '/' do
  erb:index
end

post '/suckers' do
  Sucker.create (params[:sucker])
  session[:name] = params[:name]
  redirect '/thanks'
end

get '/thanks' do
  @name = session[:name]
  erb:thanks
end

get '/suckers' do
  # "Dir is: #{settings.public_folder}"
  @people = ProcessCSV.new.fetch_suckers_data(@data_path)
  erb:suckers
end

get '/suckers/:id' do
  @people = ProcessCSV.new.fetch_single_sucker(@data_path, params[:id])
  erb:suckers_specific
end
