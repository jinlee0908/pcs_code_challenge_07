require 'csv'
require 'pry'
# this class processes csv data from the sinatra app

class ProcessCSV

  def initialize
    @count = 0 #fake ID counter for hash array
  end

  def fetch_CSV_data(filename)
    data_array = []
    #open csv, iterate through csv, concatenate fields, hash concatenated fields, put in array
    # csv = CSV.open(filename)
    # csv.drop(1).each do |row|
    csv = CSV.open(filename)
    csv.drop(1).each do |row|
      data_array << concat_row(row)
    end
    csv.close
    data_array
  end

  def concat_row(row_array)
    h = {}
    @count = @count + 1
    h[:id] = @count
    h[:name] = concat_names(row_array[0..4])
    h[:phone] = concat_phone(row_array[5..9])
    h[:twitter] = row_array[10]
    h[:email] = row_array[11]
    h
  end

  def concat_names(name_array)
    name = ""
    name_array.each do |n|
      n.empty? ? next : name = name + n + ' '
    end
    name = name.strip
  end

  def concat_phone(phone_array)
    phone = ""
    phone_array.each do |p|
      p.to_s.empty? ? next : phone = phone + p.to_s
    end 
    phone
  end

end