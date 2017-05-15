require_relative '../game'

RSpec.describe 'Running payroll' do
  subject { Game.new }

  describe '#run_payroll' do
    let(:new_balance) { 50 }
    let(:new_config) {
      {
        initialBalance: new_balance,
        payroll: {
          wage_bill: 35
        }
      }
    }

    before do
      subject.add_team({name: 'TeamA', colour: '#f00'})
      subject.add_team({name: 'TeamB', colour: '#f00'})
      subject.configure(new_config)
      subject.run_payroll
    end

    context 'when all teams have enough cash' do

      example 'their balances are reduced' do
        teams = subject.status.teams
        expect(teams['TeamA'].cashBalance).to eq(15)
        expect(teams['TeamB'].cashBalance).to eq(15)
      end
    end

    context 'when a team runs out of cash' do
      example 'their balance sticks at zero' do
        subject.run_payroll
        teams = subject.status.teams
        expect(teams['TeamA'].cashBalance).to eq(0)
        expect(teams['TeamB'].cashBalance).to eq(0)
      end
    end

  end

end

