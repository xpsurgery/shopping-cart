require_relative '../game'
require_relative '../config'

RSpec.describe 'Game#add_team' do
  subject { Game.new }

  before do
    subject.add_team('Team X')
  end

  context 'with an invalid name' do

    [ nil, '', ' ' ].each do |bad_name|
      example "team '#{bad_name}' is not added" do
        expect(subject.add_team(bad_name)).to be false
        expect(subject.status.teams.length).to eq(1)
      end
    end

  end

  context 'with a name that has already been used' do
    example 'the team is not added' do
      expect(subject.add_team('Team X')).to be false
      expect(subject.status.teams.length).to eq(1)
    end
  end

  context 'with a valid unique name' do
    let(:teams) { subject.status.teams }

    before do
      expect(subject.add_team('Team Y')).to be true
    end

    example 'the team is added' do
      expect(teams.length).to eq(2)
      expect(teams['Team Y'].name).to eq('Team Y')
    end

    example 'the team has a unique id' do
      expect(teams['Team Y'].id).to_not eq(teams['Team X'].id)
    end

    example 'the team has a balance of zero' do
      pending
      expect(teams['Team Y'].cash_balance).to eq(0)
    end

  end

end

