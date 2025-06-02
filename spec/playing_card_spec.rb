require_relative '../lib/playing_card'

describe 'PlayingCard' do
  it 'should initialize a card with a suit and rank' do
    card = PlayingCard.new('A', 'H')
    expect(card).to_not be_nil
    expect(card).to be_a PlayingCard
  end
  
end
