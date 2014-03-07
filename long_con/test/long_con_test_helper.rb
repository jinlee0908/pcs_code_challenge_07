
ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require '../long_con_app.rb'
