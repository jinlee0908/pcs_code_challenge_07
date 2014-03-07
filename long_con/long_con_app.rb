require 'sinatra'
enable :sessions

before do
  @heading = 'Born Every Minute'
  @foot = 'Copyright &copy 2014 The Long Con LLC'
  @test_data = [{ id: 1, name: 'Mrs. Theresa E. Stamm',
                  email: 'kieran@runte.biz', phone: '1-678-523-6736',
                  twitter: '@Reinger' },
                { id: 2, name: 'Keara Maggio',
                  email: 'cayla@lubowitz.com', phone: '1-399-471-4388 x9581',
                  twitter: '@Weber' }]
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
  @people = @test_data
  erb:suckers
end

get '/suckers/:id' do
  @people = @test_data.select { |person| person[:id] == params[:id].to_i }
  erb:suckers_specific
end
