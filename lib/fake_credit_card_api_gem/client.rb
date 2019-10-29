module FakeCreditCardApiGem
  class Client

    CHECK_PATH = '/check_credit_card'
    CREDIT_CARDS_PATH = '/credit_cards'

    def initialize
      @api_key = FakeCreditCardApiGem.configuration.api_key
      @host = FakeCreditCardApiGem.configuration.host
      @port = FakeCreditCardApiGem.configuration.port
      @api_end_point = "http://#{@host}:#{@port}"
    end

    def checker(number:, code:)
      url = checker_end_point
      query = { number: number, code: code }
      request(url, query)
    end

    def check_amount(number:, code:, amount:)
      url = checker_end_point
      query = { number: number, code: code, amount: amount }
      request(url, query)
    end

    def index
      url = credit_cards_end_point
      query = {}
      request(url, query)
    end

    def make_a_payment(number:, code:, amount:)
      check_response = check_amount(number: number, code: code, amount: amount)

      return check_response unless check_response["message"] == 'valid'
      credit_card_id = check_response["id"]

      url = make_a_payment_end_point(credit_card_id)
      query = { amount: amount }
      request(url, query)
    end

    private

    def checker_end_point
      @api_end_point + CHECK_PATH
    end

    def make_a_payment_end_point(credit_card_id)
      @api_end_point + payment_end_point(credit_card_id)
    end

    def credit_cards_end_point
      @api_end_point + CREDIT_CARDS_PATH
    end

    def payment_end_point(credit_card_id)
      "/credit_cards/#{credit_card_id}/payments"
    end

    def request(url, query)
      begin
        response = HTTParty.get(url, query: query, headers: request_header)
        body = JSON.parse(response.body)
      rescue Errno::ECONNREFUSED
        body = { message: 'error connecting, API server seems down' }
      end
    end

    def request_header
      {
        'Authorization'=>"Bearer #{@api_key}",
        'Content-Type' =>'application/json',
        'Accept'=>'application/json'
      }
    end

  end
end