require_relative '../lib/card_deck'

describe 'CardDeck' do
  let(:deck) { CardDeck.new }
  let(:card) { deck.deal }
  
  it 'Should have 52 cards when created' do
    expect(deck.cards_left).to eq 52
  end

  it 'should deal the top card' do
    expect(card).to_not be_nil
    expect(deck.cards_left).to eq 51
  end

  it 'should deal a card with a suit and rank' do
    expect(card).to_not be_nil
    expect(PlayingCard::RANKS).to include(card.rank)
    expect(PlayingCard::SUITS).to include(card.suit)
  end

  it 'should have a unique set of cards' do
    expect(deck.cards.uniq(&:to_s).count).to eq(deck.cards.length)
  end

  it 'should create a deck with different ranks' do
    card1 = deck.deal
    card2 = deck.deal
    expect(card1.rank).to_not eq(card2.rank)
  end

  it 'should add a card to the deck' do
    deck.add_card(card)
    expect(deck.cards).to include(card)
  end

  it 'should shuffle the cards' do
    unshuffled_deck = CardDeck.new
    expect(deck).to eq(unshuffled_deck)
    deck.shuffle!
    expect(unshuffled_deck).to_not eq(deck)
  end

  it 'should return 0 when no cards are left' do
    (deck.cards_left).times do deck.deal end
    expect(deck.cards_left).to be(0)
  end

  it 'raises an error if a deck tries to deal an empty deck' do
    expect {
      (deck.cards_left + 1).times do deck.deal end
      }.to raise_error StandardError
  end
end
