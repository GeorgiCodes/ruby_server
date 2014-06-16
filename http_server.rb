# HTTP Request
# 1) browser issues a HTTP request by opening a TCP socket to host on port 80.
require 'socket'

# this server object will listen on localhost:2345 for incoming connections
server = TCPServer.new('localhost', 2345)

WEB_ROOT = './public'

def get_file_path(request)
  if request == "" || request == nil
    return nil
  end
  puts "request is: #{request}"

  resource_to_get = request.split(" ")[1]
  puts "Resource to get: #{resource_to_get}"
  return resource_to_get
end

# loop infinitely and process each incoming connection at a time
loop do
  puts "in loop"

  # when a client connects, return a TCPSocket
  socket = server.accept

  # read the request from the socket
  resource_to_get = get_file_path(socket.gets)

  # if the file exists and is not a directory, then get its contents
  if !resource_to_get.nil? && File.exists?(resource_to_get) && !File.directory?(resource_to_get)
    response = File.read(WEB_ROOT + resource_to_get)
    puts "file found, responding to client"
  else
    puts "error opening file"
    response = "responding from server, no file existed"
  end

  # add standard headers, make not that HTTP is whitespace sensitive
  socket.print "HTTP/1.1 200 OK\r\n" +
                   "Content-Type: text/plain\r\n" +
                   "Content-Length: #{response.bytesize}\r\n" +
                   "Connection: close\r\n"

  socket.print "\r\n" # blank line between headers and response
  socket.print response

  socket.close #terminate connection after you have sent client all the required information
end