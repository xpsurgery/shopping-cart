require_relative '../game'

RSpec.describe 'Preparing to play' do
  subject { Game.new }

  describe 'Before setup has been called' do

    example 'there are no teams' do
      expect(subject.status.teams).to be_empty
    end

    example 'the game is in the setup phase' do
      expect(subject.status.phase).to eq(:setup)
    end

    example 'the game is using the default config' do
      expect(subject.status.config).to eq(Game::DEFAULTS)
    end

  end

  describe 'After setup has been called' do
    let(:new_balance) { 50 }
    let(:new_config) {
      {
        initial_balance: new_balance
      }
    }

    before do
      subject.setup(new_config)
    end

    example 'there are no teams' do
      expect(subject.status.teams).to be_empty
    end

    example 'the game is in the setup phase' do
      expect(subject.status.phase).to eq(:setup)
    end

    example 'the game is using the new config' do
      expect(subject.status.config.initial_balance).to eq(new_balance)
      expect(subject.status.config.payroll).to eq(Game::DEFAULTS.payroll)
    end

    describe 'When teams are added' do

      before do
        subject.add_team('Team A')
        subject.add_team('Team B')
      end

      example 'their initial balances match the config' do
        expect(subject.status.teams['Team A'].cash_balance).to eq(new_balance)
        expect(subject.status.teams['Team B'].cash_balance).to eq(new_balance)
      end

      example 'their ids are unique' do
        teams = subject.status.teams
        expect(teams['Team A'].id).to_not eq(teams['Team B'].id)
      end

    end

  end

end

