require_relative 'playing_card'

class CardDeck
  attr_reader :cards
  def initialize
    @cards = []
    PlayingCard::SUITS.each do |suit|
      PlayingCard::RANKS.each do |rank|
        @cards.push(PlayingCard.new(rank, suit))
      end
    end
  end

  def cards_left
    @cards.length
  end

  def deal
    cards_left
    @cards.pop
  end

  def shuffle
    @cards.shuffle
  end
end
