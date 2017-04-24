require_relative '../game'

RSpec.describe 'Preparing to play' do
  subject { Game.new }

  describe 'Before setup has been called' do

    example 'there are no teams' do
      expect(subject.status[:teams]).to be_empty
    end

    example 'the game is in the setup phase' do
      expect(subject.status[:phase]).to eq(:setup)
    end

    example 'the game is using the default config' do
      expect(subject.status[:config]).to eq(Game::DEFAULTS)
    end

  end

  describe 'After setup has been called' do
    let(:new_config) {
      {
        initial_balance: 50
      }
    }

    before do
      subject.setup(new_config)
    end

    example 'there are no teams' do
      expect(subject.status[:teams]).to be_empty
    end

    example 'the game is in the setup phase' do
      expect(subject.status[:phase]).to eq(:setup)
    end

    example 'the game is using the new config' do
      expect(subject.status[:config][:initial_balance]).to eq(50)
      expect(subject.status[:config][:payroll]).to eq(Game::DEFAULTS[:payroll])
    end

  end
end
