require_relative '../lib/card_deck'

describe 'CardDeck' do
  it 'Should have 52 cards when created' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
  end

  it 'should deal the top card' do
    deck = CardDeck.new
    card = deck.deal
    expect(card).to_not be_nil
    expect(deck.cards_left).to eq 51
  end

  it 'should deal a card with a suit and rank' do
    deck = CardDeck.new
    card = deck.deal
    expect(card).to_not be_nil
    expect(PlayingCard::RANKS).to include(card.rank)
    expect(PlayingCard::SUITS).to include(card.suit)
  end

  it 'should create a deck with different ranks' do
    deck = CardDeck.new
    card1 = deck.deal
    card2 = deck.deal
    expect(card1.rank).to_not eq(card2.rank)
  end

  it 'should shuffle the cards' do
    unshuffled_deck = CardDeck.new
    shuffled_deck = unshuffled_deck.shuffle
    expect(unshuffled_deck.cards).to_not eq(shuffled_deck)
  end
end
