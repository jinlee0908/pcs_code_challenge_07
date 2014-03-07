require 'sinatra'
enable :sessions

before do
  @heading = 'Born Every Minute'
  @foot = 'Copyright &copy 2014 The Long Con LLC'
  @data = '/people20.csv'
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
  @people = fetch_csv_data(@data)
  erb:suckers
end

get '/suckers/:id' do
  @people = @test_data.select { |person| person[:id] == params[:id].to_i }
  erb:suckers_specific
end
