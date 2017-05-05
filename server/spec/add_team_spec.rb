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

    example 'the team is added with a unique id' do
      expect(subject.add_team('Team Y')).to be true
      teams = subject.status.teams
      expect(teams.length).to eq(2)
      expect(teams['Team Y'].name).to eq('Team Y')
      expect(teams['Team Y'].id).to_not eq(teams['Team X'].id)
    end

  end

end

