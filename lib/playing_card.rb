class PlayingCard
  attr_reader :rank, :suit
  SUITS = ['S', 'H', 'D', 'C']
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end
