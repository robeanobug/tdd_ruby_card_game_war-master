class WarPlayer
  attr_accessor :name, :hand
  PLAYER_COUNT = 2
  def initialize(name)
    @name = name
    @hand = []
  end

  def add_card(card)
    hand << card
  end

  def play_card
    hand.pop
  end

  def is_out_of_cards
    hand.empty?
  end
end
