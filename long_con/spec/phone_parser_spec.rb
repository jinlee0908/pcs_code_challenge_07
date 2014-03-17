require 'spec_helper'
require './lib/parse.rb'

describe Parse do
  class ParseClass
  end

  before(:all) do
    @parse = ParseClass.new
    @parse.extend Parse
  end

  describe Parse do
    it 'should parse number without country code' do
      return_array = @parse.parse_numbers('345-234-1244-x342')
      expect(return_array).to
      eq(country: '', area: '345', prefix: '234', line: '1244', ext: '342')
    end

    it 'should parse number without an ext' do
      return_array = @parse.parse_numbers('1-345-234-1244')
      expect(return_array).to
      eq(country: '1', area: '345', prefix: '234', line: '1244', ext: '')
    end

    it 'should parse number without country code and ext' do
      return_array = @parse.parse_numbers('345-234-1244')
      expect(return_array).to
      eq(country: '', area: '345', prefix: '234', line: '1244', ext: '')
    end

    it 'should parse number without country code or ext' do
      return_array = @parse.parse_numbers('345-234-1244')
      expect(return_array).to
      eq(country: '', area: '345', prefix: '234', line: '1244', ext: '')
    end

    it 'should parse number with () as a separator' do
      return_array = @parse.parse_numbers('(345)234-1244')
      expect(return_array).to
      eq(country: '', area: '345', prefix: '234', line: '1244', ext: '')
    end

    it 'should parse number with . as a separator' do
      return_array = @parse.parse_numbers('1.345.234.1244.x345')
      expect(return_array).to
      eq(country: '1', area: '345', prefix: '234', line: '1244', ext: '345')
    end

    it 'should parse number with space as a separator' do
      return_array = @parse.parse_numbers('1 345 234 1244 x345')
      expect(return_array).to
      eq(country: '1', area: '345', prefix: '234', line: '1244', ext: '345')
    end

    it 'should parse number with ext of more than 3' do
      return_array = @parse.parse_numbers('1 345 234 1244 x34545')
      expect(return_array).to
      eq(country: '1', area: '345', prefix: '234', line: '1244', ext: '34545')
    end

    it 'should parse number with ext of less than 3' do
      return_array = @parse.parse_numbers('1 345 234 1244 x34')
      expect(return_array).to
      eq(country: '1', area: '345', prefix: '234', line: '1244', ext: '34')
    end

    it 'should parse number with ext without a leading x' do
      return_array = @parse.parse_numbers('1 345 234 1244 3434')
      expect(return_array).to
      eq(country: '1', area: '345', prefix: '234', line: '1244', ext: '3434')
    end
  end
end
