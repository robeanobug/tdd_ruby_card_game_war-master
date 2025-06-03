require_relative '../lib/war_game'
class DummyDeck < CardDeck
  def shuffle
    # nothing
  end
end
describe 'WarGame' do
  it 'should initialize the game with player1 and player2' do
    game = WarGame.new
    expect(game).to_not be_nil
    expect(game.player1).to be_a WarPlayer
    expect(game.player2).to be_a WarPlayer
  end

  it 'should deal an equal amount of cards to the players' do
    game = WarGame.new
    game.deal_cards
    expect(game.player1.hand.length).to eq(26)
  end

  xit 'should start the game' do
    # unsure what to test
  end

  it 'should play a round' do
    game = WarGame.new
    game.deal_cards
    
    # expect(game.play_round).to be_a WarPlayer
    # what to expect at the end of the round, look at number of cards in player's hands when they start with one card each
  end

  xit 'should have both players lay down another card if it is a tie' do
    # set up tie scenario maybe like dummy deck or accessing more cards from the players' hands
  end

  xit 'should pick the card with the higher value' do
    
  end

  xit 'should collect the cards and give them to the player' do
    
  end

  it 'should declare a winner when a player runs out of cards' do
    game = WarGame.new
    game.start
  end
end
