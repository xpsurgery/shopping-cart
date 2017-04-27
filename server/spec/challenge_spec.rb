require_relative '../game'

def expect_errors(id, payload, expected_errors)
  errors = {}
  subject.answer(id, payload,
    lambda {|_| fail 'Should not reach here' },
    lambda {|e| errors = e })
  expect(errors.errors).to eq(expected_errors)
end

RSpec.describe 'Completing challenges' do
  let(:new_balance) { 50 }
  let(:new_config) {
    {
      initial_balance: new_balance,
      payroll: {
        wage_bill: 35
      },
      sales: {
        expiry_secs: 3,
        fine_for_late_attempt: 100
      }
    }
  }
  subject { Game.new }

  before do
    subject.setup(new_config)
    subject.add_team('Team A')
    subject.add_team('Team B')
  end

  context 'when we are not playing' do

    example 'an error is returned' do
      expect_errors('0', {}, ['Please wait until the game is in progress'])
    end

  end

  context 'when we are playing' do

    before do
      subject.play(false)
    end

    context 'but there was no such challenge' do

      example 'an error is returned' do
        payload = Hashie::Mash.new({ teamName: 'Team B' })
        expect_errors('0', payload, ["No challenge with id 0 has been issued"])
      end

    end

    context 'and the challenge was issued' do
      let(:challenge) { subject.issue_challenge }

      context 'and answered with' do

        context 'no team name' do
          example 'an error is returned' do
            payload = Hashie::Mash.new({})
            expect_errors(challenge.id, payload, ['Please supply your team name'])
          end
        end

        context 'an unknown team name'

        context 'after the challenge has expired' do
          let(:answer) {
            Hashie::Mash.new({
              teamName: 'Team B'
            })
          }

          example 'an error is returned' do
            expect_errors(challenge.id, answer, ["Challenge #{challenge.id} has timed out"])
          end

          example 'the team is fined' do
          end

        end

        context 'everything correct'

        context 'tax but no discount'

        context 'discount but no tax'

        context 'neither tax nor discount'

        context 'an unfathomable answer'

      end

    end

  end

end
