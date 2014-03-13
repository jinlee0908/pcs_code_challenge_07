require 'sinatra'
require 'csv'
require 'benchmark'
require_relative 'lib/parse.rb'
require_relative 'lib/process_csv.rb'
enable :sessions

before do
  @heading = 'Born Every Minute'
  @foot = 'Copyright &copy 2014 The Long Con LLC'
  @data_path = "#{settings.public_folder}/people.csv"
end

iterations = 100

Benchmark.bmbm(15) do |bm|
  bm.report('get homepage') do
    iterations.times {
      get '/' do
        erb:index 
      end }
  end
end

Benchmark.bmbm(7) do |bm|
  bm.report('post sucker/redirect') do
    iterations.times {
      post '/suckers' do
        if params.empty?
          redirect '/'
        else
          @new_sucker = Parse.new.parse_stuff(params[:name], params[:phone], params[:twitter], params[:email])
          ProcessCSV.new.write_to_csv(@data_path, @new_sucker)
          session[:name] = params[:name]
          redirect '/thanks'
        end
      end }
  end
end

Benchmark.bmbm(15) do |bm|
  bm.report('display thanks') do
    iterations.times {
      get '/thanks' do
        @name = session[:name]
        erb:thanks
      end }
  end
end

Benchmark.bmbm(15) do |bm|
  bm.report('display all') do
    iterations.times {
      get '/suckers' do
        @people = ProcessCSV.new.fetch_suckers_data(@data_path)
        erb:suckers
      end }
  end
end

Benchmark.bmbm(8) do |bm|
  bm.report('display specific') do
    iterations.times {
      get '/suckers/:id' do
        @people = ProcessCSV.new.fetch_single_sucker(@data_path, params[:id])
        erb:suckers_specific
      end }
  end
end
