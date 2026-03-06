require 'socket'
require_relative 'lib/request.rb'
require_relative 'lib/response.rb'
require_relative 'lib/router.rb'

class HTTPServer

  def initialize(port)
    # give port var its value for use when starting server
    @port = port
  end

  def start
    # start server and print information to terminal
    server = TCPServer.new(@port)
    puts "Listening on #{@port}"
    puts "http://localhost:4567"

    # wait until a user connects to server
    while session = server.accept
      # create data variable and print to terminal
      data = ''
      while line = session.gets and line !~ /^\s*$/
        data += line
      end
      puts '-' * 80
      puts data
      puts '-' * 80

      # get data from request
      request = Request.new(data)

      router = Router.new(request.resource)
      router.get_file_path
      
      response = Response.new(router.file_path)

      session.print
      session.close
      
    end
  end
end

# create new server object and start it with port 4567
server = HTTPServer.new(4567)
server.start
