require 'spec_helper'
require './lib/parse.rb'

describe Parse do
  class ParseClass
  end

  before(:all) do
    @parse = ParseClass.new
    @parse.extend Parse
  end

# The format of the names looks to be something like:

#     [prefix] [first_name] [middle_name | middle_initial] last_name [suffix]

# where:

# * Everything in [square brackets] is optional.
# * There may be a middle name or a middle initial, but not both.
# * If there is a middle name or a last name, there will be a first name.
# *(For 'M. Jackson', 'M.' is the first name.)
# * There is always a last name (For 'Miss Jane,' 'Jane' is a last name)
# * Sometimes the last name is hyphenated (as in
# * 'Dr. Huntington-Smythe'). Do not split hyphenated last names.

  describe Parse do

    it 'should parse last names' do
      return_array = @parse.parse_names('Madona')
      expect(return_array).to
      eq(pre: '', first: '', middle: '', last: 'Madona', suffix: '')
    end

    it 'should parse suffixes' do
      return_array = @parse.parse_names('Madona Jr.')
      expect(return_array).to
      eq(pre: '', first: '', middle: '', last: 'Madona', suffix: 'Jr.')
    end

    it 'should parse first names' do
      return_array = @parse.parse_names('Mary Madona')
      expect(return_array).to
      eq(pre: '', first: 'Mary', middle: '', last: 'Madona', suffix: '')
    end

    it 'should parse first names with suffixes ' do
      return_array = @parse.parse_names('Mary Madona Jr.')
      expect(return_array).to
      eq(pre: '', first: 'Mary', middle: '', last: 'Madona', suffix: 'Jr.')
    end

    it 'should parse middle names' do
      return_array = @parse.parse_names('Mary Samuel Madona')
      expect(return_array).to
      eq(pre: '', first: 'Mary', middle: 'Samuel', last: 'Madona', suffix: '')
    end

    it 'should parse middle initials' do
      return_array = @parse.parse_names('Mary S. Madona')
      expect(return_array).to
      eq(pre: '', first: 'Mary', middle: 'S.', last: 'Madona', suffix: '')
    end

    it 'should parse middle names & suffixes' do
      return_array = @parse.parse_names('Mary Samuel Madona III')
      expect(return_array).to
      eq(pre: '', first: 'Mary', middle: 'Samuel',
         last: 'Madona', suffix: 'III')
    end

    it 'should parse prefixes and last names' do
      return_array = @parse.parse_names('Mrs. Madona')
      expect(return_array).to
      eq(pre: 'Mrs.', first: '', middle: '', last: 'Madona', suffix: '')
    end

    it 'should parse prefixes and last names and suffixes' do
      return_array = @parse.parse_names('Mrs. Madona III')
      expect(return_array).to
      eq(pre: 'Mrs.', first: '', middle: '', last: 'Madona', suffix: 'III')
    end

    it 'should parse the whole banana' do
      return_array = @parse.parse_names('Mrs. Mary Samuel Madona-Richey III')
      expect(return_array).to
      eq(pre: 'Mrs.', first: 'Mary', middle: 'Samuel',
         last: 'Madona-Richey', suffix: 'III')
    end
  end
end
