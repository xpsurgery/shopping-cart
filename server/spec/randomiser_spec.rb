require_relative '../randomiser'

RSpec.describe Randomiser do
  let(:region_names) { ['JP', 'UK', 'US', 'AU'] }
  subject { Randomiser.new(region_names) }

  example 'every instance is different' do
    two = Randomiser.new(region_names)
    expect(region_names).to include(subject.region_name)
    expect(region_names).to include(two.region_name)
    expect(subject.unit_price).to_not eq(two.unit_price)
    expect(subject.num_items).to_not eq(two.num_items)
  end

  example 'the number of items is at least 15' do
    expect(subject.num_items).to be >= 15
  end

  example 'the number of items is at most 140' do
    expect(subject.unit_price).to be < 140
  end

  example 'the unit price is at least 15' do
    expect(subject.unit_price).to be >= 15
  end

  example 'the unit price is at most 140' do
    expect(subject.unit_price).to be < 140
  end

end
