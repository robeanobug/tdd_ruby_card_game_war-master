require_relative 'card_deck'
require_relative 'war_player'

class WarGame
  attr_accessor :player1, :player2, :deck
  def initialize(deck = CardDeck.new)
    @player1 = WarPlayer.new('Player1')
    @player2 = WarPlayer.new('Player2')
    @deck = deck
  end

  def deal_cards
    deck.shuffle!
    until deck.cards_left < 1
      player1.hand << deck.deal
      player2.hand << deck.deal
    end
  end

  def play_round(pot = [])
    pot = add_to_pot(pot)
    round_winner = determine_round_winner(pot)
    round_winner.add_card(pot)
    round_winner.hand = round_winner.hand.flatten
  end

  def add_to_pot(pot = [])
    player1_card = player1.play_card
    player2_card = player2.play_card
    pot.push(player1_card, player2_card)
  end

  def determine_round_winner(pot = [])
    if pot[-2].to_value > pot[-1].to_value
      return player1
    elsif pot[-1].to_value > pot[-2].to_value
      return player2
    end
  end

  def tie?
    player1.is_out_of_cards && player2.is_out_of_cards
  end

  def winner
    return player1 if player2.is_out_of_cards
    return player2 if player1.is_out_of_cards
  end

  def start
    deal_cards
  end
end
