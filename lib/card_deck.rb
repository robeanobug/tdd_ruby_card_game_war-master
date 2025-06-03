require_relative 'playing_card'

class CardDeck
  attr_reader :cards
  DECK_SIZE = 52
  def initialize
    @cards = build_deck
  end

  def build_deck
    PlayingCard::SUITS.map do |suit|
      PlayingCard::RANKS.map do |rank|
        PlayingCard.new(rank, suit)
      end
    end.flatten
  end

  def cards_left
    cards.length
  end

  def deal
    raise StandardError if cards_left == 0
    cards.pop
  end

  def add_card(card)
    cards.unshift(card)
  end

  def shuffle!
    cards.shuffle!
  end

  def to_s
	  "Rank: #{rank} Suit: #{suit}"
  end

  def ==(other_deck)
    cards == other_deck.cards
  end
end
