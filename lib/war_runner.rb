require_relative 'war_game'
require_relative 'fake_war_game'
# 1_000.times do
  game = FakeWarGame.new
  game.start
  until game.winner do
    puts game.play_round
  end
  puts "Winner: #{game.winner.name}"
# end