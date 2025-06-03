require_relative '../lib/war_game'
class DummyDeck < CardDeck
  def shuffle!
    # overwrites shuffle opperation
  end
end

describe 'WarGame' do
  let (:game) { WarGame.new }

  describe '#initialize' do
    it 'should initialize the game with player1 and player2' do
      expect(game).to_not be_nil
      expect(game.player1).to be_a WarPlayer
      expect(game.player2).to be_a WarPlayer
    end
  end

  describe '#deal_cards' do
    it 'should deal an equal amount of cards to the players' do
      game.deal_cards
      expect(game.player1.hand.length).to eq(CardDeck::DECK_SIZE/WarPlayer::PLAYER_COUNT)
    end
  end

  describe '#play_round' do
    it 'should add to pot' do
      players_count = 2
      game.player1.hand = [PlayingCard.new('K', 'H')]
      game.player2.hand = [PlayingCard.new('A', 'H')]
      pot = game.add_to_pot

      expect(pot.length).to eq(players_count)
    end
    it 'should return round winner of player with higher card' do
      pot = [PlayingCard.new('K', 'H'), PlayingCard.new('A', 'H')]

      expect(game.determine_round_winner(pot)).to eq(game.player2)
    end
    it 'should return false if players lay down cards of same value' do
      pot = [PlayingCard.new('K', 'H'), PlayingCard.new('K', 'S')]
  
      expect(game.determine_round_winner(pot)).to be_falsey
    end
    it 'should collect the cards and give them to the player' do
      players_count = 2
      game.player1.hand = [PlayingCard.new('3', 'H')]
      game.player2.hand = [PlayingCard.new('4', 'H')]
      game.play_round
  
      expect(game.player2.hand.length).to eq(players_count)
    end
  end
  
  describe '#winner' do
    it 'should declare a winner when a player runs out of cards' do
      game.player1.hand = []
      game.player2.hand = [PlayingCard.new('3', 'H')]
      winner = game.winner

      expect(winner).to eq(game.player2)
    end
  end

  describe '#tie?' do
    it 'should return true if it is a tie' do
      game.player1.hand = []
      game.player2.hand = []

      expect(game.tie?).to be_truthy
    end
    it 'should return false if it is not a tie' do
      game.player1.hand = [PlayingCard.new('3', 'H')]
      game.player2.hand = []
  
      expect(game.tie?).to be_falsey
    end
  end

  describe '#start' do
    it 'should deal the cards' do
      game.start

      expect(game.player1.hand.length).to eq(CardDeck::DECK_SIZE/WarPlayer::PLAYER_COUNT)
    end
  end
end
