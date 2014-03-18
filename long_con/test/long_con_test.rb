require_relative 'long_con_test_helper.rb'
require 'pry'

before do
  @test_data = { name: 'Mrs. Theresa E. Stamm',
                 email: 'kieran@runte.biz',
                 phone: '1-678-523-6736',
                 twitter: '@Reinger' }

#  @sucker = Sucker.new(@test_data)
end

# test class
class MyTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_long_con
    get '/'
    assert last_response.ok?

    post '/suckers'
    assert last_response.redirect?

    get '/suckers'
    assert last_response.ok?

    get '/suckers/:id'
    assert last_response.ok?

    get '/thanks'
    assert last_response.ok?
  end

  def test_sucker_added_to_database
    post '/suckers', { name: 'Mrs. Theresa E. Stamm',
                 email: 'kieran@runte.biz',
                 phone: '1-678-523-6736',
                 twitter: '@Reinger' }
    follow_redirect!
    assert_equal suckers.last, { id: 1,
                      prefix_name: 'Mrs.',
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
  end

  def test_other_sucker_not_on_specific_page
    get '/suckers/2'
    refute last_response.body.include?('Mrs. Theresa E. Stamm')
  end
end
