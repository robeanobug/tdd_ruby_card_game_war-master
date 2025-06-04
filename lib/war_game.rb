require_relative 'card_deck'
require_relative 'war_player'

class WarGame
  attr_accessor :player1, :player2, :deck, :round
  def initialize(deck = CardDeck.new)
    @player1 = WarPlayer.new('Player 1')
    @player2 = WarPlayer.new('Player 2')
    @deck = deck
    @round = 0
  end

  def deal_cards
    deck.shuffle!
    until deck.cards_left < 1
      player1.hand << deck.deal
      player2.hand << deck.deal
    end
  end

  def play_round(pot = [])
    return winner if winner
    pot = add_to_pot(pot)
    round_winner = determine_round_winner(pot)
    return play_round(pot) unless round_winner
    round_winner.add_card(pot)
    round_winner.hand = round_winner.hand.flatten
    print_message(round_winner, pot[-2], pot[-1])
  end

  def print_message(round_winner, player1_card, player2_card)
    if player1 == round_winner
    return "#{round_winner.name} took #{player2_card.rank} of #{player2_card.suit} with #{player1_card.rank} of #{player1_card.suit}"
    else
    return "#{round_winner.name} took #{player1_card.rank} of #{player1_card.suit} with #{player2_card.rank} of #{player2_card.suit}"
    end
  end
  
  def winner
    return player1 if player2.is_out_of_cards
    return player2 if player1.is_out_of_cards
  end

  def winner_message(winner)
    "Winner: #{winner.name}!"
  end
  
  def start
    deal_cards
  end
  
  private
  
  def add_to_pot(pot = [])
    self.round += 1
    player1_card = player1.play_card
    player2_card = player2.play_card
    pot.shuffle! # shuffles cards already in pot to avoid games that go infinite
    pot.push(player1_card, player2_card)
  end
  
  def determine_round_winner(pot = [])
    return player1 if pot[-2].to_value > pot[-1].to_value
    return player2 if pot[-1].to_value > pot[-2].to_value
  end
end
