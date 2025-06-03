require_relative 'card_deck'
require_relative 'war_player'

class WarGame
  attr_accessor :player1, :player2, :deck, :played_cards
  def initialize(deck = CardDeck.new)
    @player1 = WarPlayer.new('Player1')
    @player2 = WarPlayer.new('Player2')
    @deck = deck
    @played_cards = []
  end

  def deal_cards
    deck.shuffle!
    until deck.cards_left < 1
      player1.hand << deck.deal
      player2.hand << deck.deal
    end
  end

  def play_round
    # return of the players run out of cards in their hand
    return if player1.hand.nil? || player2.hand.nil?
    # players play a card from the top of the deck
    played_cards.push(player1.hand.shift)
    played_cards.push(player2.hand.shift)
    # if it's a tie, play round again
    if played_cards[-2] == played_cards[-1]
      puts "War! Put another card down."
      play_round 
    # if player1's card is higher than player2's card then player1 collects
    elsif played_cards[-2].to_index > played_cards[-1].to_index
      player1.hand.concat(played_cards)
      puts "Player 1: #{played_cards[-2].rank}#{played_cards[-2].suit} Player 2: #{played_cards[-1].rank}#{played_cards[-1].suit}"
      puts "Player 1 won this round."
      # played_cards = []
      player1
    # else (if player2's card is higher, player2 collects)
    else
      player2.hand.concat(played_cards)
      puts "Player 1: #{played_cards[-2].rank}#{played_cards[-2].suit} Player 2: #{played_cards[-1].rank}#{played_cards[-1].suit}"
      puts "Player 2 won this round."
      # played_cards = []
      player2
    end
  end

  def winner
    if player1.hand.empty?
      puts "#{player2.name} wins the game!"
      return true
    elsif player2.hand.empty?
      puts "#{player1.name} wins the game!"
      return true
    end
    false
  end

  def start
    deal_cards
    until winner
      play_round
    end
  end
end
