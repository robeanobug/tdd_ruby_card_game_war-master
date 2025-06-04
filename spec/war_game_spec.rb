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
    it 'should call play_round again in the case of a round tie' do
      game.player1.hand = [PlayingCard.new('King', 'Hearts'), PlayingCard.new('King', 'Hearts')]
      game.player2.hand = [PlayingCard.new('Ace', 'Hearts'), PlayingCard.new('King', 'Spades')]
      game.play_round

      expect(game.player1.hand.empty?).to be_truthy
      expect(game.player2.hand.length).to eq 4
    end

    it 'should add pot to player1 when winner' do
      game.player1.hand = [PlayingCard.new('Ace', 'Hearts')]
      game.player2.hand = [PlayingCard.new('King', 'Hearts')]
      game.play_round

      expect(game.player1.hand.length).to eq 2
      expect(game.player2.hand.empty?).to be_truthy
    end

    it 'should add pot to player2 when winner' do
      game.player1.hand = [PlayingCard.new('King', 'Hearts')]
      game.player2.hand = [PlayingCard.new('Ace', 'Hearts')]
      game.play_round

      expect(game.player2.hand.length).to eq 2
      expect(game.player1.hand.empty?).to be_truthy
    end

    it "should return round player2 if they have the higher card" do
      game.player1.hand = [PlayingCard.new('King', 'Hearts')]
      game.player2.hand = [PlayingCard.new('Ace', 'Hearts')]
      message = game.play_round

      expect(message).to eq('Player 2 took King of Hearts with Ace of Hearts')
    end

    it 'should collect the cards and give them to the player' do
      players_count = 2
      game.player1.hand = [PlayingCard.new('3', 'Hearts')]
      game.player2.hand = [PlayingCard.new('4', 'Hearts')]
      game.play_round
  
      expect(game.player2.hand.length).to eq(players_count)
    end
    
    it 'should return player1 if player2 runs out of cards during a war' do
      game.player1.hand = [PlayingCard.new('Ace', 'Hearts'), PlayingCard.new('King', 'Spades')]
      game.player2.hand = [PlayingCard.new('King', 'Hearts')]
      winner = game.play_round

      expect(winner).to eq(game.player1)
    end

    it 'should return player2 if player1 runs out of cards during a war' do
      game.player1.hand = [PlayingCard.new('King', 'Hearts')]
      game.player2.hand = [PlayingCard.new('Ace', 'Hearts'), PlayingCard.new('King', 'Spades')]
      winner = game.play_round

      expect(winner).to eq(game.player2)
    end

    it 'should add 1 to the round counter' do
      game.player1.hand = [PlayingCard.new('King', 'Hearts')]
      game.player2.hand = [PlayingCard.new('Ace', 'Hearts')]
      game.play_round

      expect(game.round).to eq(1)
    end
  end
  
  describe '#winner' do
    it 'should declare a winner when a player runs out of cards' do
      game.player1.hand = []
      game.player2.hand = [PlayingCard.new('3', 'Hearts')]
      winner = game.winner

      expect(winner).to eq(game.player2)
    end

    it 'should return false if players still have cards' do
      game.player1.hand = [PlayingCard.new('4', 'Hearts')]
      game.player2.hand = [PlayingCard.new('3', 'Hearts')]
      winner = game.winner

      expect(winner).to be_falsey
    end
  end

  describe '#start' do
    it 'should deal the cards' do
      game.start

      expect(game.player1.hand.length).to eq(CardDeck::DECK_SIZE/WarPlayer::PLAYER_COUNT)
    end
  end
end
