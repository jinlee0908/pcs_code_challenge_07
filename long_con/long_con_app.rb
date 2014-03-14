require 'sinatra'
require 'data_mapper'

require_relative 'lib/parse.rb'
require_relative 'lib/process_csv.rb'
enable :sessions

DataMapper.setup(:default, "sqlite3://#{settings.root}/suckers20.sqlite3")

class Sucker
  include DataMapper::Resource
  property :id, Serial
  property :prefix, String
  property :first_name, String
  property :middle_name, String
  property :last_name, String
  property :suffix, String
  property :country_code, String
  property :area_code, String
  property :prefix, String
  property :line, String
  property :extension, String
  property :twitter, String
  property :email, String
  property :created_at, DateTime
end

DataMapper.finalize
Sucker.auto_upgrade!

before do
  @heading = 'Born Every Minute'
  @foot = 'Copyright &copy 2014 The Long Con LLC'
  @data_path = "#{settings.public_folder}/suckers20.sqlite3"
end

get '/' do
  erb:index
end

post '/suckers' do
  if params.empty?
    redirect '/'
  else
    @new_sucker = Sucker.new(params[:sucker])
    #or
    Sucker.create params[:sucker]
    session[:name] = params[:sucker].name
    redirect '/thanks'
  end
end

get '/thanks' do
  @name = session[:name]
  erb:thanks
end

get '/suckers' do
  # "display all the suckers"
  @people = ??????
  erb:suckers
end

get '/suckers/:id' do
  # display an individual sucker
  @people = Suckers.get params[:id]
  erb:suckers_specific
end
