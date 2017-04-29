require 'hashie/mash'
require 'uuidtools'

class Challenge

  attr_reader :challenge, :valid_responses

  def initialize(config, timestamp = Time.now)
    region_name = config.regions.keys.sample
    region = config.regions[region_name]
    num_items = 15 + Random.rand(125)
    unit_price = 15 + Random.rand(125)
    @challenge = Hashie::Mash.new({
      id: UUIDTools::UUID.timestamp_create.to_s,
      region: region_name,
      numberOfItems: num_items,
      unitPrice: unit_price,
      issuedAt: timestamp,
      expiresAt: timestamp + config.sales.expiry_secs
    })
    basic = num_items * unit_price
    @valid_responses = Hashie::Mash.new({
      correct: 34,
      tax_but_no_discount: 34,
      discount_but_no_tax: 34,
      no_tax_or_discount: basic
    })
  end

end

