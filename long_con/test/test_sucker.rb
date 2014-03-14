require './long_con_test_helper.rb'
require_relative '../lib/sucker.rb'

# test class
class TestSucker < MiniTest::Unit::TestCase
  
  def setup
    @test_sucker =  { prefix: 'Mrs.',
                      first_name: 'Theresa',
                      middle_name: 'E.',
                      last_name: 'Stamm',
                      suffix: '',
                      country_code: 1,
                      area_code: 678,
                      prefix_code: 523,
                      line: 6736,
                      extension: '',
                      twitter: 'Reinger',
                      email: 'kieran@runte.biz' 
                      }

  end

  # def teardown
  #   @sucker.destroy
  # end

  def test_sucker_can_display_name
    @sucker = Sucker.new()
    expected = 'Mrs. Theresa E. Stamm'
    assert_equal expected, @sucker.display_name
  end

  def test_sucker_can_display_phone
    expected = '1-678-523-6736'
    assert_equal expected, Sucker.new.display_phone(@test_sucker)
  end

  def test_sucker_exists
    assert_instance_of Sucker, Sucker.new
  end

  def test_create_a_sucker
    skip
    @new_sucker = Sucker.new(:email => 'test@example.com')
    assert_equal 'test@example.com', @new_sucker.email
  end

end