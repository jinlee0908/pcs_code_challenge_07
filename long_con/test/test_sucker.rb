require_relative 'long_con_test_helper.rb'
require_relative '../lib/sucker.rb'
require 'data_mapper'

# test class
class TestSucker < MiniTest::Unit::TestCase
  def setup # rubocop:disable MethodLength
    @test_db_sucker = { prefix_name: 'Mrs.',
                        first_name: 'Theresa',
                        middle_name: 'E.',
                        last_name: 'Stamm',
                        suffix: '',
                        country_code: '1',
                        area_code: '678',
                        prefix_code: '523',
                        line: '6736',
                        extension: '',
                        twitter: 'Reinger',
                        email: 'kieran@runte.biz'
                        }

    @test_form_sucker = { name: 'Mrs. Theresa E. Stamm',
                          phone: '1-678-523-6736',
                          twitter: '@Reinger',
                          email: 'kieran@runte.biz'
                          }

    @sucker = Sucker.new(@test_form_sucker)
  end

  def teardown
    # destroy sucker object
    @sucker.destroy
    # destory sucker record in db
    s = Sucker.last
    s.destroy
  end

  def test_sucker_exists
    assert_instance_of Sucker, @sucker
  end

  def test_sucker_has_name_data
    assert_equal @test_db_sucker[:prefix_name], @sucker.prefix_name
    assert_equal @test_db_sucker[:first_name], @sucker.first_name
    assert_equal @test_db_sucker[:middle_name], @sucker.middle_name
    assert_equal @test_db_sucker[:last_name], @sucker.last_name
    assert_equal @test_db_sucker[:suffix], @sucker.suffix
  end

  def test_sucker_has_phone_data
    assert_equal @test_db_sucker[:country_code], @sucker.country_code
    assert_equal @test_db_sucker[:area_code], @sucker.area_code
    assert_equal @test_db_sucker[:prefix_code], @sucker.prefix_code
    assert_equal @test_db_sucker[:line], @sucker.line
    assert_equal @test_db_sucker[:extension], @sucker.extension
  end

  def test_sucker_has_other_data
    assert_equal @test_db_sucker[:twitter], @sucker.twitter
    assert_equal @test_db_sucker[:email], @sucker.email
  end

  def test_sucker_can_display_name
    expected = 'Mrs. Theresa E. Stamm'
    assert_equal expected, @sucker.display_name
  end

  def test_sucker_can_display_phone
    expected = '1-678-523-6736'
    assert_equal expected, @sucker.display_phone
  end
end
