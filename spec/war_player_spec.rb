require_relative '../lib/war_player'

describe 'WarPlayer' do
  let(:player) { WarPlayer.new('Robyn') }
  it 'should initialize a name' do
    expect(player.name).to eq('Robyn')
  end

  it 'should hold a hand' do
    expect(player.hand).to_not be_nil
  end

  it 'should add a card to the player hand' do
    player.add_card(['card'])
    expect(player.hand.length).to eq(1)
  end

  it 'takes a card off the top of the player hand' do
    player.hand = [PlayingCard.new('A', 'H')]
    card = player.play_card
    expect(card).to be_a PlayingCard
    expect(card.rank).to eq('A')
  end

  it 'returns true if hand is empty' do
    player.hand = []

    expect(player.is_out_of_cards).to be_truthy
  end

  it 'returns false if hand is not empty' do
    player.hand = [PlayingCard.new('A', 'H')]

    expect(player.is_out_of_cards).to be_falsey
  end
end
