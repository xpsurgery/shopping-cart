require_relative '../game'

def expect_errors(id, payload, expected_error)
  errors = {}
  subject.answer(id, payload,
    lambda {|_| fail 'Should not reach here' },
    lambda {|e| errors = e })
  expect(errors.errors).to include(expected_error)
end

RSpec.describe 'Completing challenges' do
  let(:new_balance) { 5000 }
  let(:new_config) {
    {
      initial_balance: new_balance,
      payroll: {
        wage_bill: 35
      },
      sales: {
        commission: 800,
        expiry_secs: 3,
        penalty_for_late_attempt: 100
      },
      regions: {
        UK: {
          sales_tax_percent: 6.85,
          discount_bands: [
            { total_less_than:  1000, discount_percent: 0 },
            { total_less_than:  5000, discount_percent: 3 },
            { total_less_than:  9000, discount_percent: 5 },
            { total_less_than: 13000, discount_percent: 7 },
            { discount_percent: 8.5 }
          ]
        }
      }
    }
  }
  subject { Game.new }

  before do
    subject.setup(new_config)
    subject.add_team('Team A')
    subject.add_team('Team B')
  end

  context 'when we are playing' do

    before do
      subject.play(false)
    end

    context 'but there was no such challenge' do

      example 'an error is returned' do
        payload = Hashie::Mash.new({ teamName: 'Team B' })
        expect_errors('0', payload, "No challenge with id 0 has been issued")
      end

    end

    context 'and the challenge was issued' do
      let(:issued_at) { Time.now }
      let(:challenge) { subject.issue(issued_at) }

      context 'and answered with' do

        context 'no team name' do
          example 'an error is returned' do
            payload = Hashie::Mash.new({})
            expect_errors(challenge.id, payload, 'Please supply your team name')
          end
        end

        context 'an unknown team name' do

          example 'an error is returned' do
            payload = Hashie::Mash.new({ teamName: 'Team X' })
            expect_errors('0', payload, "Unknown team 'Team X'")
          end

        end

        context 'no answer' do

          example 'an error is returned' do
            payload = Hashie::Mash.new({ teamName: 'Team B' })
            expect_errors(challenge.id, payload, "Please supply an answer to the challenge")
          end

        end

        context 'after the challenge has expired' do
          let(:issued_at) { Time.now - 200 }
          let(:answer) {
            Hashie::Mash.new({
              teamName: 'Team B'
            })
          }

          example 'an error is returned' do
            expect_errors(challenge.id, answer, "Challenge #{challenge.id} has timed out")
          end

          example 'the team is fined' do
            errors = {}
            subject.answer(challenge.id, answer, lambda {}, lambda{|_|})
            expect(subject.status.teams['Team B'].cash_balance).to eq(4900)
          end

        end

        context 'everything correct' do
          let(:answer) {
            Hashie::Mash.new({
              teamName: 'Team B',
              answer: 123
            })
          }

          example 'the response indicates success' do
            reply = nil
            subject.answer(challenge.id, answer,
              lambda {|resp| reply = resp },
              lambda {|errors| fail 'Should not reach here' })
            expect(reply.income).to eq(800)
          end

          example 'the team earns commission' do
            subject.answer(challenge.id, answer, lambda {|_|}, lambda{|_|})
            expect(subject.status.teams['Team B'].cash_balance).to eq(5800)
          end
        end

        context 'tax but no discount'

        context 'discount but no tax'

        context 'neither tax nor discount'

        context 'an unfathomable answer'

      end

    end

  end

end
