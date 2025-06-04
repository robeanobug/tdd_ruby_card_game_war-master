require 'socket'
require_relative '../lib/war_socket_server'

class MockWarSocketClient
  attr_reader :socket
  attr_reader :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def capture_output(delay=0.1)
    sleep(delay)
    @output = @socket.read_nonblock(200_000) # not gets which blocks
  rescue IO::WaitReadable
    @output = ""
  end

  def close
    @socket.close if @socket
  end
end

describe WarSocketServer do
  before(:each) do
    @clients = []
    @server = WarSocketServer.new
    @server.start
    # puts "server listening"
    sleep 0.1 # Ensure server is ready for clients
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  let (:client1) { MockWarSocketClient.new(@server.port_number) }
  let (:client2) { MockWarSocketClient.new(@server.port_number) }

  # to do helper methods for setup players
  # setup game helper method

  it "is not listening on a port before it is started"  do
    @server.stop
    expect {MockWarSocketClient.new(@server.port_number)}.to raise_error(Errno::ECONNREFUSED)
  end

  it "accepts new clients and starts a game if possible" do
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    @server.create_game_if_possible
    expect(@server.games.count).to be 0

    @clients.push(client2)
    @server.accept_new_client("Player 2")
    @server.create_game_if_possible
    expect(@server.games.count).to be 1
  end

  it 'first clients get a welcome message' do
    @clients.push(client1)
    @server.accept_new_client("Player 1")

    expect(client1.capture_output).to match /welcome/i
  end

  it 'all clients get a message when the game starts' do
    # client1 = MockWarSocketClient.new(@server.port_number)
    @clients.push(client1)
    @server.accept_new_client("Player 1")

    @clients.push(client2)
    @server.accept_new_client("Player 2")
    @server.create_game_if_possible

    expect(client1.capture_output).to match /starting/i
    expect(client2.capture_output).to match /starting/i
  end

  it 'should play round when both players are ready and output to client' do
    @clients.push(client1)
    @server.accept_new_client("Player 1")
    client1.provide_input('Ready! Player 1')

    @clients.push(client2)
    @server.accept_new_client("Player 2")
    client2.provide_input('Ready! Player 2')

    @server.create_game_if_possible
    @server.play_next_round
    
    expect(@server.games.first.round).to eq 1
    expect(client1.capture_output).to match /player/i
  end

  it 'should not play a round if both players are not ready' do
    @clients.push(client1)
    @clients.push(client2)

    @server.accept_new_client("Player 1")
    @server.accept_new_client("Player 2")

    client1.provide_input('Ready!')

    @server.create_game_if_possible
    @server.play_next_round
    
    expect(@server.games.first.round).to eq 0
  end

  it 'should not play a round until both players are ready' do
    @clients.push(client1)
    @clients.push(client2)

    @server.accept_new_client("Player 1")
    @server.accept_new_client("Player 2")

    @server.create_game_if_possible
    @server.play_next_round
    
    expect(@server.games.first.round).to eq 0
  end

  it 'should run game' do
    @clients.push(client1)
    @clients.push(client2)

    @server.accept_new_client("Player 1")
    @server.accept_new_client("Player 2")

    @server.create_game_if_possible
    @server.run_game
    
    expect(client1.capture_output).to match /winner/i
  end

  # Add more tests to make sure the game is being played
  # For example:
  #   make sure the mock client gets appropriate output
  #   make sure the next round isn't played until both clients say they are ready to play
  #   ...
  #   
  # TO DO:
  # get server working
  # 
  # refactor tests
  # - helper method for player setup
  # - helper method for game setup
end
