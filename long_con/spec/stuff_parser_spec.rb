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
  	it "should parse everything from the form" do
		  return_array = @parse.parse_stuff('Ciara X. Windler II', '575 225 1469 240', '@Labadie', 'ryan_moore@hagenesmiller.com')
    	expected = [['', 'Ciara', 'X.', 'Windler', 'II'], ['', '575', '225', '1469', '240'], ['Labadie'], ['ryan_moore@hagenesmiller.com']]
    	assert_equal expected, return_array
    end
  end
end

#Mini Test test moved to match other parse related tests

  # 	def test_parse_stuff
  #   @csv = Parse.new
  #   return_array = @csv.parse_stuff('Ciara X. Windler II', '575 225 1469 240', '@Labadie', 'ryan_moore@hagenesmiller.com')
  #   expected = [['', 'Ciara', 'X.', 'Windler', 'II'], ['', '575', '225', '1469', '240'], ['Labadie'], ['ryan_moore@hagenesmiller.com']]
  #   assert_equal expected, return_array
  # end