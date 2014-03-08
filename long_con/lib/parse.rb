class Parse


  def self.parse_names(prefixes, suffixes, name_string)
    parsed_name = { pre: '', first: '', middle: '', last: '', suffix: '' }
    word = name_string.split
    parsed_name[:suffix] = word.pop if suffixes.include? word.last
    parsed_name[:last] = word.pop
    parsed_name[:pre] = word.shift if prefixes.include? word.first
    parsed_name[:first] = word.shift || word[0] = ''
    parsed_name[:middle] = word.shift || word[0] = ''
    parsed_name.values
  end

  def self.parse_twitter(data)
    twitter = /\w+/
    [twitter.match(data).to_s]
  end

  def self.parse_email(email_string)
    email_regex = /\w+\@\w+\.\w+/
    email_regex.match(email_string) ? [email_string] : ['Not Found']
  end

  def self.parse_numbers(numbers)
    parse_number = {  country: '', area: '', prefix: '', line: '', ext: '' }
    num = numbers.scan(/\d+/)
    parse_number[:country] = num.shift if num[0] == '1'
    parse_number[:area] = num.shift
    parse_number[:prefix] = num.shift
    parse_number[:line] = num.shift
    parse_number[:ext] = num.shift || num[0] = ''
    parse_number.values
  end
end