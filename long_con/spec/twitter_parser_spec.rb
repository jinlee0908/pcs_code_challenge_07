require 'spec_helper'
require './lib/parse.rb'

describe Parse do
  class Parse_class
  end

  before(:all) do
    @parse = Parse_class.new
    @parse.extend Parse
  end

  describe Parse do
    it "should accept twitter handles without ampersand" do
      return_array = @parse.parse_twitter('pluto')
      expect(return_array).to eq(['pluto'])
    end

    it "should remove amersand" do
      return_array = @parse.parse_twitter('@tiger')
      expect(return_array).to eq(['tiger'])
    end

    it "should accept words with underscores" do
      return_array = @parse.parse_twitter('@winnie_the_pooh')
      expect(return_array).to eq(['winnie_the_pooh'])
    end

    it "should accept words with mixed case letters" do
      return_array = @parse.parse_twitter('@ScroogeMcDuck')
      expect(return_array).to eq(['ScroogeMcDuck'])
    end

    it "should accept letters and numbers" do
      return_array = @parse.parse_twitter('@I3U')
      expect(return_array).to eq(['I3U'])
    end

    it "should accept only numbers" do
      return_array = @parse.parse_twitter('1234')
      expect(return_array).to eq(['1234'])
    end
  end
end
