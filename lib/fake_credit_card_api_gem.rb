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
  HEADER = 

  def self.checker(number:, code:)
    api_path = CHECK_PATH
    url = "http://#{configuration.host}:#{configuration.port}#{api_path}"
    query = { number: number, code: code }
    headers = header(configuration.api_key)
    begin
      response = HTTParty.get(url, query: query, headers: headers)
      body = JSON.parse(response.body)
    rescue Errno::ECONNREFUSED
      body = { message: 'error connecting, API server seems down' }
    end
  end

  def self.check_amount(number:, code:, amount:)
    api_path = CHECK_PATH
    url = "http://#{configuration.host}:#{configuration.port}#{api_path}"
    query = { number: number, code: code, amount: amount }
    headers = header(configuration.api_key)
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
    headers = header(configuration.api_key)
    begin
      response = HTTParty.get(url, query: query, headers: headers)
      body = JSON.parse(response.body)
    rescue Errno::ECONNREFUSED
      body = { message: 'error connecting, API server seems down' }
    end
  end

  def self.make_a_payment(number:, code:, amount:)
    check_response = self.check_amount(number: number, code: code, amount: amount)
    return check_response unless check_response["message"] == 'valid'
    credit_card_id = check_response["id"]

    url = "http://#{configuration.host}:#{configuration.port}/credit_cards/#{credit_card_id}/payments"
    query = { amount: amount }
    headers = header(configuration.api_key)
    begin
      response = HTTParty.post(url, query: query, headers: headers)
      body = JSON.parse(response.body)
    rescue Errno::ECONNREFUSED
      body = { message: 'error connecting, API server seems down' }
    end
  end

  def self.header(api_key)
    {
      'Authorization'=>"Bearer #{api_key}",
      'Content-Type' =>'application/json',
      'Accept'=>'application/json'
    }
  end
end
