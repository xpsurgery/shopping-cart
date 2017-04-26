require_relative '../game'

RSpec.describe 'Completing challenges' do
  let(:new_balance) { 50 }
  let(:new_config) {
    {
      initial_balance: new_balance,
      payroll: {
        wage_bill: 35
      }
    }
  }
  let(:id) { '1234' }                 # TODO: random guids
  subject { Game.new }

  before do
    subject.setup(new_config)
    subject.add_team('first')
    subject.add_team('second')
  end

  context 'when we are not playing' do

    example 'an error is returned' do
      errors = {}
      subject.answer(id, {},
        lambda {|_| fail 'Should not reach here' },
        lambda {|e| errors = e })
      expect(errors.errors[0]).to eq('Please wait until the game is in progress')
    end

  end

  context 'when we are playing' do

    before do
      subject.play
    end

    context 'but there was no such challenge'

    context 'and the challenge was issued' do

      context 'and answered with' do

        context 'no team name'

        context 'everything correct'

        context 'tax but no discount'

        context 'discount but no tax'

        context 'neither tax nor discount'

        context 'an unfathomable answer'

      end

    end

  end

end
