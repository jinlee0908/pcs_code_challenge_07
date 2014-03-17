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
    it "should parse email with name '@' and domain" do
      return_array = @parse.parse_email('strawhatalexander@gmail.com')
      expect(return_array).to eq('strawhatalexander@gmail.com')
    end

    it "should parse email just '@' domain and return Not Found" do
      return_array = @parse.parse_email('@gmail.com')
      expect(return_array).to eq('Not Found')
    end

    it "should parse email with just a name and no domain or '@' " do
      return_array = @parse.parse_email('thisisanemailbelieveitornot')
      expect(return_array).to eq('Not Found')
    end

    it 'should parse email with just domain' do
      return_array = @parse.parse_email('@gmail.com')
      expect(return_array).to eq('Not Found')
    end
  end
end
