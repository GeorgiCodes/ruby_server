require 'socket'

TCPSocket.open('localhost', 2000) do |socket|
  loop
    message = gets.chomp #wait until the client write a message on terminal

    socket.puts message #send the message to server
    puts socket.gets #print the answer from the server
  do
end