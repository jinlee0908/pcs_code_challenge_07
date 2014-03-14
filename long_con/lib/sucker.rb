require 'data_mapper'
require_relative 'parse.rb'

# Sucker object
class Sucker

  include Parse
  include DataMapper::Resource

  property :id, Serial
  property :prefix_name, String
  property :first_name, String
  property :middle_name, String
  property :last_name, String
  property :suffix, String
  property :country_code, String
  property :area_code, String
  property :prefix_code, String
  property :line, String
  property :extension, String
  property :twitter, String
  property :email, String, :required => true
  property :created_at, DateTime

  def initialize(params)
    #remember we got to change the suffix and prefix in parse module
    parsed_names = parse_names(params[:name])
    self.prefix_name = parsed_names[:pre]
    self.first_name = parsed_names[:first]
    self.middle_name = parsed_names[:middle]
    self.last_name = parsed_names[:last]
    self.suffix = parsed_names[:suffix]
    
    parsed_number = parse_numbers(params[:phone])
    self.country_code = parsed_number[:country]
    self.area_code = parsed_number[:area]
    self.prefix_code = parsed_number[:prefix]
    self.line = parsed_number[:line]
    self.extension = parsed_number[:ext]
    
    self.twitter = parse_twitter(params[:twitter])
    self.email = parse_email(params[:email])
  end

  def display_name
    name = [self.prefix_name, 
            self.first_name, 
            self.middle_name,
            self.last_name,
            self.suffix]
    name.select{ |i| i.size > 0 }.join(' ')
  end

  def display_phone
    phone = [self.country_code,
             self.area_code,
             self.prefix_code,
             self.line,
             self.extension]
    phone.select{ |i| i.size > 0 }.join('-') 
  end

end