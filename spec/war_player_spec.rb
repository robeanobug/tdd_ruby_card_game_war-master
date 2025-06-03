require_relative '../lib/war_player'

describe 'WarPlayer' do
  it 'should initialize a name' do
    name = 'Robyn'
    player = WarPlayer.new(name)
    expect(player.name).to eq(name)
  end

  it 'should hold a hand' do
    name = 'Robyn'
    player = WarPlayer.new(name)
    expect(player.hand).to_not be_nil
  end
end
