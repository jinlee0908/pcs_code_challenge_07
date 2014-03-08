require 'sinatra'
require 'csv'
require_relative 'public/parse.rb'
require_relative 'lib/process_csv.rb'
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
  @new_sucker = parse_stuff 
  write_to_csv(@new_sucker)
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

def write_to_csv(sucker)
  CSV.open(@data_path, "a") do |csv|
    csv << sucker.flatten
  end  
end
def parse_stuff
  @prefixes = ["Mrs.", "Miss", "Ms", "Dr.", "Mr.","mrs.", "miss", "ms", "dr.", "mr."]
  @suffixes = ["DDS", "MD", "Sr.", "IV", "DVM", "I", "II", "Jr.", "V", "III", "Phd"]
  csv_ready = []
  csv_ready << Parse.parse_names(@prefixes, @suffixes, params[:name])
  csv_ready<< Parse.parse_numbers(params[:phone])
  csv_ready << Parse.parse_twitter(params[:twitter])
  csv_ready << Parse.parse_email(params[:email])
  csv_ready
end
