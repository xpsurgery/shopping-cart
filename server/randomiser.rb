class Randomiser

  attr_reader :region_name, :num_items, :unit_price

  def initialize(region_names)
    @region_name = region_names.sample
    @num_items = 15 + Random.rand(125)
    @unit_price = 15 + Random.rand(125)
  end
end

