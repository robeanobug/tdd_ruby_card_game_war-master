require 'socket'
require_relative 'war_game'
require_relative 'war_player'
class WarSocketServer
  def initialize
  end

  def port_number
    3336
  end

  def games
    @games ||= []
  end

  def clients
    @clients ||= []
  end

  def players
    @players ||= []
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(player_name = "Random Player")
    client = @server.accept_nonblock
    player = WarPlayer.new(player_name)
    players.push player
    clients.push client
    client.puts 'Welcome to War!'
    # associate player and client
  rescue IO::WaitReadable, Errno::EINTR
    puts "No client to accept"
  end

  def create_game_if_possible
    if players.count == 2
      game = WarGame.new
      game.start
      games << game
      clients.each do |client|
        client.puts 'War is starting...'
      end
    end
  end

  def play_next_round
    responses = []
    clients.each do |client|
      client.puts "Press enter to play the round."
      begin
        sleep(0.1)
        responses << client.read_nonblock(1000)
      rescue IO::WaitReadable
      end
    end
    message = games.first.play_round if responses.size > 1
    send_to_client(message)
  end

  def send_to_client(message)
    clients.each do |client|
      client.puts message
    end
  end

  def stop
    @server.close if @server
  end
end
