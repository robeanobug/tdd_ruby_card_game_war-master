require_relative '../lib/playing_card'

describe 'PlayingCard' do
  it 'should initialize a card with a suit and rank' do
    card = PlayingCard.new('A', 'H')
    expect(card).to_not be_nil
    expect(card).to be_a PlayingCard
  end

  it 'should return true when 2 cards are equal' do
    card1 = PlayingCard.new('A', 'H')
    card2 = PlayingCard.new('A', 'H')

    expect(card1).to eq(card2)
  end

  it 'should return the value of a card' do
    value = PlayingCard.new('A', 'H').to_value
    expect(value).to eq(12)
  end
end
