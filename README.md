# FakeCreditCardApiGem

## Installation
`gem 'fake_credit_card_api_gem', git: 'git@github.com:cmramseyer/fake_credit_card_api_gem.git'`  
  
Create `config/initializers/fake_credit_card_api_gem.rb` and add  
```ruby
FakeCreditCardApiGem.configure do |config|
  config.api_key = ENV['CREDIT_CARD_APP_KEY']
  config.host = ENV['CREDIT_CARD_API_HOST']
  config.port = ENV['CREDIT_CARD_API_PORT']
end
```

## Usage
`FakeCreditCardApiGem.checker(number: '12345', code: '123')` to check if the credit card exists and is valid  
`FakeCreditCardApiGem.index` to see the list of current credit cards  



