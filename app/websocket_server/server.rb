require 'eventmachine'
require 'em-websocket'

class SetlistWebsocketServer
  
  HOST = "192.168.1.101"
  PORT = 8080
  
  def initialize
  end
  
  def start
    fork do
      EM.run {
        @websocket_connections = []
        
        EM::WebSocket.start( :host => HOST, :port => PORT ) do |socket|
          socket.onopen { open socket }
    
          socket.onmessage { |message| broadcast message }
    
          socket.onclose { destroy socket }
        end
      }
    end
  end
  
  private
  
  def open(socket)
    puts "New websocket connection opened"
    @websocket_connections << socket
    puts "The current sockets are:"
    @websocket_connections.each do |socket|
      puts socket.request["Origin"]
    end
  end
  
  def destroy(socket)
    puts "Websocket connection closed"
    @websocket_connections.delete(socket)
  end
  
  def broadcast(message)
    @websocket_connections.each do |socket|
      socket.send "#{message}"
    end 
  end
  
end
