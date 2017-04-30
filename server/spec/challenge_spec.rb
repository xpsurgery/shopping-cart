require_relative '../challenge'

RSpec.describe 'Creating challenges' do
  let(:config) {
    Hashie::Mash.new({
      sales: {
        expiry_secs: 3
      },
      regions: {
        UK: {
          sales_tax_percent: 6.85,
          discount_bands: [
            { total_less_than:  1000, percent_discount: 0 },
            { total_less_than:  5000, percent_discount: 3 },
            { total_less_than:  9000, percent_discount: 5 },
            { total_less_than: 13000, percent_discount: 7 },
            { percent_discount: 8.5 }
          ]
        }
      }
    })
  }

  context 'when the discount band is somewhere in the middle' do

    let(:randomiser) {
      Hashie::Mash.new({
        region_name: 'UK',
        num_items: 87,
        unit_price: 64
      })
    }
    subject { Challenge.new(config, randomiser) }

    it 'initialises the challenge using the randomiser' do
      challenge = subject.challenge
      expect(challenge.region).to eq('UK')
      expect(challenge.numberOfItems).to eq(87)
      expect(challenge.unitPrice).to eq(64)
    end

    describe 'valid responses' do
      let(:valid_responses) { subject.valid_responses }

      it 'rounds down only at the end of the calculation' do
        expect(valid_responses.no_tax_or_discount).to eq(5568)
        expect(valid_responses.tax_but_no_discount).to eq(5949)
        expect(valid_responses.discount_but_no_tax).to eq(5289)
        expect(valid_responses.correct).to eq(5651)
      end
    end

  end

  context 'when the last discount band applies' do

    let(:randomiser) {
      Hashie::Mash.new({
        region_name: 'UK',
        num_items: 134,
        unit_price: 98
      })
    }
    subject { Challenge.new(config, randomiser) }

    it 'initialises the challenge using the randomiser' do
      challenge = subject.challenge
      expect(challenge.region).to eq('UK')
      expect(challenge.numberOfItems).to eq(134)
      expect(challenge.unitPrice).to eq(98)
    end

    describe 'valid responses' do
      let(:valid_responses) { subject.valid_responses }

      it 'rounds down only at the end of the calculation' do
        expect(valid_responses.no_tax_or_discount).to eq(13132)
        expect(valid_responses.tax_but_no_discount).to eq(14031)
        expect(valid_responses.discount_but_no_tax).to eq(12015)
        expect(valid_responses.correct).to eq(12838)
      end
    end

  end

end
