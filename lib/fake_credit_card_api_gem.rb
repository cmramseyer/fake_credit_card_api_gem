require "fake_credit_card_api_gem/railtie"
require "httparty"
require "json"

require 'byebug'

require 'fake_credit_card_api_gem/client'


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

end
