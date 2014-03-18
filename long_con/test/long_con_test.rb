require_relative 'long_con_test_helper.rb'
require 'data_mapper'
require 'pry'

# test class
class MyTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    @params_hash = {
      sucker: {
        name: 'Mrs. Theresa E. Stamm',
        email: 'kieran@runte.biz',
        phone: '1-678-523-6736',
        twitter: '@Reinger'
      }
    }
  end

  def test_long_con
    get '/'
    assert last_response.ok?

    post '/suckers', @params_hash
    Sucker.create(@params_hash[:sucker])
    assert last_response.redirect?

    get '/suckers'
    assert last_response.ok?

    # get '/suckers/:id'
    # assert last_response.ok?

    get '/thanks'
    assert last_response.ok?
  end

  def test_sucker_added_to_database
    post '/suckers', @params_hash
    s = Sucker.create(@params_hash[:sucker])
    follow_redirect!
    assert_equal 'Mrs.', s.prefix_name
    assert_equal 'Theresa', s.first_name
    assert_equal 'E.', s.middle_name
    assert_equal 'Stamm', s.last_name
    assert_equal '1', s.country_code
    assert_equal '678', s.area_code
    assert_equal '523', s.prefix_code
    assert_equal '6736', s.line
    assert_equal '', s.extension
    assert_equal 'Reinger', s.twitter
    assert_equal 'kieran@runte.biz', s.email
  end

  def test_suckers_on_suckers_page
    get '/suckers'
    assert last_response.body.include?('kieran@runte.biz')
    assert last_response.body.include?('Mrs. Theresa E. Stamm')
  end

  def test_not_a_sucker_on_suckers_page
    get '/suckers'
    refute last_response.body.include?('fake@email.com')
  end

  def test_single_sucker_on_specific_page
    get '/suckers/2'
    assert last_response.body.include?('Keara Maggio')
    assert last_response.ok?
  end

  def test_other_sucker_not_on_specific_page
    get '/suckers/2'
    refute last_response.body.include?('Mrs. Theresa E. Stamm')
  end
end
