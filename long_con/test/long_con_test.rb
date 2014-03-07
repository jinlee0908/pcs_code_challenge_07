require './long_con_test_helper.rb'

before do
  @test_data = [{ id: 1,
                  name: 'Mrs. Theresa E. Stamm',
                  email: 'kieran@runte.biz',
                  phone: '1-678-523-6736',
                  twitter: '@Reinger' },
                { id: 2,
                  name: 'Keara Maggio',
                  email: 'cayla@lubowitz.com',
                  phone: '1-399-471-4388 x9581',
                  twitter: '@Weber' }]
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

  def test_name_on_thanks
    post '/suckers', name: 'Jin'
    follow_redirect!
    assert last_response.body.include?('Jin')
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
