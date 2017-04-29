require_relative '../challenge'

RSpec.describe 'Creating challenges' do
  let(:config) {
    Hashie::Mash.new({
      sales: {
        expiry_secs: 3
      },
      regions: {
        UK: {
          sales_tax: 6.85,
          discount_bands: [
            { total_less_than:  1000, discount: 0.00 },
            { total_less_than:  5000, discount: 0.03 },
            { total_less_than:  9000, discount: 0.05 },
            { total_less_than: 13000, discount: 0.07 },
            { discount: 0.085 }
          ]
        },
        JP: {
          sales_tax: 3.00,
          discount_bands: [
            { total_less_than:  1000, discount: 0.00 },
            { total_less_than:  5000, discount: 0.02 },
            { total_less_than:  9000, discount: 0.04 },
            { total_less_than: 13000, discount: 0.06 },
            { discount: 0.09 }
          ]
        }
      }
    })
  }
  subject { Challenge.new(config) }

  it 'calculates the valid responses correctly' do
    challenge = subject.challenge
    valid_responses = subject.valid_responses
    puts challenge
    puts valid_responses
    expect(valid_responses.no_tax_or_discount).to eq(challenge.numberOfItems * challenge.unitPrice)
    region_name = challenge.region
    expect(['UK', 'JP']).to include(region_name)
  end

end
