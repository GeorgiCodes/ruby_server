require 'socket'

server = TCPServer.new 2000

loop do
  client = server.accept # wait for a client to connect
  msg_received = client.gets
  puts "Msg received from client #{msg_received}"
  client.puts "i gots your msg yo!"

  # client.close
end