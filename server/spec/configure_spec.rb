require_relative '../game'
require_relative '../config'

RSpec.describe 'Preparing to play' do
  subject { Game.new }

  describe 'Before configure has been called' do

    example 'there are no teams' do
      expect(subject.status.teams).to be_empty
    end

    example 'the game is in the setup phase' do
      expect(subject.status.phase).to eq(:setup)
    end

    example 'the game is using the default config' do
      expect(subject.status.config).to eq(Config::DEFAULTS)
    end

  end

  describe 'After configure has been called' do
    let(:new_balance) { 50 }
    let(:new_config) {
      {
        initial_balance: new_balance
      }
    }

    before do
      subject.configure(new_config)
    end

    example 'there are no teams' do
      expect(subject.status.teams).to be_empty
    end

    example 'the game is in the ready phase' do
      expect(subject.status.phase).to eq(:paused)
    end

    example 'the game is using the new config' do
      expect(subject.status.config.initial_balance).to eq(new_balance)
      expect(subject.status.config.payroll).to eq(Config::DEFAULTS.payroll)
    end

  end

end

