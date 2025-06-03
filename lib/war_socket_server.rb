require 'socket'
require_relative 'war_game'
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
      games << WarGame.new
      clients.each do |client|
        client.puts 'War is starting...'
      end
    end
  end

  def stop
    @server.close if @server
  end
end