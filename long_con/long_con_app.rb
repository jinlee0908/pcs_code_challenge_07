require 'sinatra'
require_relative './lib/process_csv.rb'

enable :sessions

before do
  @heading = 'Born Every Minute'
  @foot = 'Copyright &copy 2014 The Long Con LLC'
  @data_path = "#{settings.public_folder}/people20.csv"
end

get '/' do
  erb:index
end

post '/suckers' do
  session[:name] = params[:name]
  redirect '/thanks'
end

get '/thanks' do
  @name = session[:name]
  erb:thanks
end

get '/suckers' do
  # "Dir is: #{settings.public_folder}"
  @people = ProcessCSV.new.fetch_CSV_data(@data_path)
  erb:suckers
end

get '/suckers/:id' do
  @people = @test_data.select { |person| person[:id] == params[:id].to_i }
  erb:suckers_specific
end
