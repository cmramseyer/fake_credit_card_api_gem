require 'spec_helper'

RSpec.describe 'lala' do
  before(:each) do
    FakeCreditCardApiGem.stub_chain(:configuration, :api_key).and_return("1234")
    FakeCreditCardApiGem.stub_chain(:configuration, :host).and_return("localhost")
    FakeCreditCardApiGem.stub_chain(:configuration, :port).and_return(3005)

    @client = FakeCreditCardApiGem::Client.new
    @header = {
      'Accept'=>'application/json',
      'Authorization'=>'Bearer 1234',
      'Content-Type'=>'application/json'
      }
  end
  context '#index' do
    before(:each) do
      stub_request(:get, "http://localhost:3005/credit_cards").
      with(headers: @header)
      .to_return(status: 200, body: '{"message": "lala"}', headers: {})
    end

    it 'lala' do
      @client.index
      expect(WebMock).to have_requested(:get, "http://localhost:3005/credit_cards").with(query: '', headers: @header)
    end
  end

  context '#make_a_payment' do
    before(:each) do
      stub_request(:get, "http://localhost:3005/check_credit_card").
      with(query: {number: '123', code: '456', amount: '999.99'}, headers: @header)
      .to_return(status: 200, body: '{"message": "valid", "id": "101"}', headers: {})

      stub_request(:post, "http://localhost:3005/credit_cards/101/payments").
      with(query: {amount: '999.99'}, headers: @header)
      .to_return(status: 200, body: '{"message": "ok"}', headers: {})
    end

    it 'lala' do
      @client.make_a_payment(number: 123, code: 456, amount: 999.99)
    end
  end
end