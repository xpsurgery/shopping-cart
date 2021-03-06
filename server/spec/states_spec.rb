require_relative '../game'
require_relative '../config'

RSpec.describe 'Game state machine' do
  subject { Game.new }

  context 'when the current phase is :setup' do

    example 'start is valid' do
      expect(subject.start[0]).to eq(200)
    end

    example 'add_team is valid' do
      expect(subject.add_team({name: 'fred', colour: '#f00'})[0]).to eq(200)
    end

    example 'configure is valid' do
      expect(subject.configure(Config::DEFAULTS)[0]).to eq(200)
    end

    example 'play is not valid' do
      expect(subject.play(false)[0]).to eq(400)
    end

    example 'pause is not valid' do
      expect(subject.pause[0]).to eq(400)
    end

    example 'restart is not valid' do
      expect(subject.restart[0]).to eq(400)
    end

  end

  context 'when the current phase is :playing' do

    before do
      subject.add_team({name: 'fred', colour: '#f00'})
      subject.configure(Config::DEFAULTS)
      subject.play(false)
    end

    example 'start is not valid' do
      expect(subject.start[0]).to eq(400)
    end

    example 'add_team is not valid' do
      expect(subject.add_team({name: 'joe', colour: '#f00'})[0]).to eq(400)
    end

    example 'configure is not valid' do
      expect(subject.configure(Config::DEFAULTS)[0]).to eq(400)
    end

    example 'play is not valid' do
      expect(subject.play(false)[0]).to eq(400)
    end

    example 'pause is valid' do
      expect(subject.pause[0]).to eq(200)
    end

    example 'restart is not valid' do
      expect(subject.restart[0]).to eq(400)
    end

  end

  context 'when the current phase is :paused' do

    before do
      subject.add_team({name: 'fred', colour: '#f00'})
      subject.configure(Config::DEFAULTS)
      subject.play(false)
      subject.pause
    end

    example 'start is valid' do
      expect(subject.start[0]).to eq(200)
    end

    example 'add_team is not valid' do
      expect(subject.add_team({name: 'joe', colour: '#f00'})[0]).to eq(400)
    end

    example 'configure is not valid' do
      expect(subject.configure(Config::DEFAULTS)[0]).to eq(400)
    end

    example 'play is valid' do
      expect(subject.play(false)[0]).to eq(200)
    end

    example 'pause is not valid' do
      expect(subject.pause[0]).to eq(400)
    end

    example 'restart is valid' do
      expect(subject.restart[0]).to eq(200)
    end

  end

end

