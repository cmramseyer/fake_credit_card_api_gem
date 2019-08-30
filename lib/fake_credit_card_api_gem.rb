require "fake_credit_card_api_gem/railtie"
require "httparty"
require "json"

require 'byebug'


module FakeCreditCardApiGem

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_key, :host, :port
  end

  CHECK_PATH = '/check_credit_card'
  CREDIT_CARDS_PATH = '/credit_cards'

  def self.checker(number:, code:)
    api_path = CHECK_PATH
    url = "http://#{configuration.host}:#{configuration.port}#{api_path}"
    query = { number: number, code: code }
    headers = {
        'Authorization'=>"Bearer #{configuration.api_key}",
        'Content-Type' =>'application/json',
        'Accept'=>'application/json'
    }
    begin
      response = HTTParty.get(url, query: query, headers: headers)
      body = JSON.parse(response.body)
    rescue Errno::ECONNREFUSED
      body = { message: 'error connecting, API server seems down' }
    end
  end

  def self.index
    api_path = CREDIT_CARDS_PATH
    url = "http://#{configuration.host}:#{configuration.port}#{api_path}"
    query = {}
    headers = {
        'Authorization'=>"Bearer #{configuration.api_key}",
        'Content-Type' =>'application/json',
        'Accept'=>'application/json'
    }
    begin
      response = HTTParty.get(url, query: query, headers: headers)
      body = JSON.parse(response.body)
    rescue Errno::ECONNREFUSED
      body = { message: 'error connecting, API server seems down' }
    end
  end
end