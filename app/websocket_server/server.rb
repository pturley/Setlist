require 'rubygems'
require 'eventmachine'
require 'em-websocket'

class SetlistWebsocketServer
  def self.start
    fork do
      EM.run {
        websocket_connections = []
  
        EM::WebSocket.start(:host => "10.2.12.38", :port => 8080) do |ws|
          ws.onopen {
            ws.send "Hello Client!"
            puts "Websocket connection opened"
            websocket_connections << ws
            puts "The sockets are:"
            websocket_connections.each do |socket|
              puts socket.request["Origin"]
            end
          }
    
          ws.onmessage do |msg| 
            websocket_connections.each do |socket|
              socket.send "#{msg}"
            end 
          end
    
          ws.onclose {
            puts "Websocket connection closed"
            websocket_connections.delete(ws)
          }
        end
      }
    end
  end
end
