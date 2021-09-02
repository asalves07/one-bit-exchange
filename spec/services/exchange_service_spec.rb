require 'rails_helper'
require 'json'

describe ExchangeService do
  let(:source_currency) { 'USD' }
  let(:target_currency) { 'BRL' }
  let(:exchange_value)  { 5.19 }
  let(:api_return) do
    {
      currency: [
        currency: "#{source_currency}/#{target_currency}",
        value: exchange_value,
        date: Time.now,
        type: 'Original'
      ]
    }
  end

  before do
    allow(RestClient).to receive(:get) { OpenStruct.new(body: api_return.json) }
  end

  it '#call' do
    amount = rand(0..9999)
    service_exchange = described_class.new('USD', 'BRL', amount).call
    expected_exchange = amount * exchange_value
    expect(service_exchange).to eq expected_exchange
  end
end