require 'data_mapper'
require 'parse.rb'

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

  def initialize(name, phone, twitter, email)
    #remember we got to change the suffix and prefix in parse module
    parsed_names = Parse.parse_names(name)
    :prefix_name = parsed_names[:pre]
    :first_name = parsed_names[:first]
    :middle_name = parsed_names[:middle]
    :last_name = parsed_names[:last]
    :suffix = parsed_names[:suffix]
    parsed_number = Parse.parse_number(phone)
    :country_code = parsed_number[:country]
    :area_code = parsed_number[:area]
    :prefix_code = parsed_number[:prefix]
    :line = parsed_number[:line]
    :extension = parsed_number[:ext]
    
    :twitter = Parse.parse_twitter(twitter)
    :email = Parse.parse_email(email)
  end

  def display_name(sucker)
    name = [sucker[:prefix_name], 
            sucker[:first_name], 
            sucker[:middle_name],
            sucker[:last_name],
            sucker[:suffix]]
    name.select{ |i| i.size > 0 }.join(' ')
  end

  def display_phone(sucker)
    phone = [sucker[:country_code],
             sucker[:area_code],
             sucker[:prefix_code],
             sucker[:line],
             sucker[:extension]]
    phone.select{ |i| i.size > 0 }.join('-') 
  end

  def display_sucker

  end

end