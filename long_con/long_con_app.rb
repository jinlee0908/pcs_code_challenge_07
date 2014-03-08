require 'sinatra'
require 'csv'
require_relative 'lib/parse.rb'
require_relative 'lib/process_csv.rb'
enable :sessions

before do
  @heading = 'Born Every Minute'
  @foot = 'Copyright &copy 2014 The Long Con LLC'
  @data_path = "#{settings.public_folder}/people.csv"
end

get '/' do
  erb:index
end

post '/suckers' do
  if params.empty?
    redirect '/'
  else
    @new_sucker = Parse.new.parse_stuff(params[:name], params[:phone], params[:twitter], params[:email])
    ProcessCSV.new.write_to_csv(@data_path, @new_sucker)
    session[:name] = params[:name]
    redirect '/thanks'
  end
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
