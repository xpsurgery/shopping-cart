require 'hashie/mash'
require 'uuidtools'

class Challenge

  attr_reader :challenge, :valid_responses

  def initialize(config, randomiser, timestamp = Time.now)
    config = config
    region_name = randomiser.region_name
    num_items = randomiser.num_items
    unit_price = randomiser.unit_price
    @challenge = Hashie::Mash.new({
      id: UUIDTools::UUID.timestamp_create.to_s,
      region: region_name,
      numberOfItems: num_items,
      unitPrice: unit_price,
      issuedAt: timestamp,
      expiresAt: timestamp + config.sales.expiry_secs
    })

    @region = config.regions[region_name]
    basic = num_items * unit_price
    @valid_responses = Hashie::Mash.new({
      correct: taxed(discounted(basic)).floor,
      tax_but_no_discount: taxed(basic).floor,
      discount_but_no_tax: discounted(basic).floor,
      no_tax_or_discount: basic
    })
  end

  private

  def taxed(basic)
    (basic * (1.0 + @region.sales_tax_percent/100.0))
  end

  def discounted(basic)
    basic * (100.0 - discount(basic))/100.0
  end

  def discount(basic)
    @region.discount_bands.each do |band|
      if band.percent_discount
        if basic < band.total_less_than
          return band.percent_discount
        end
      else
        return band.percent_discount
      end
    end
    return 0
  end

end

