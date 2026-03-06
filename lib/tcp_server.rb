require 'socket'
require_relative 'request.rb'
require_relative 'response.rb'

class HTTPServer

  def initialize(router, port)
    # give port var its value for use when starting server
    @port = port
    @router = router
  end

  def start
    # start server and print information to terminal
    server = TCPServer.new(@port)
    puts "\nServer started"
    puts "Listening on #{@port}"
    puts "http://localhost:4567\n\n"

    # wait until a user connects to server
    while session = server.accept
      # create data variable and print to terminal
      data = ''
      while line = session.gets and line !~ /^\s*$/
        data += line
      end

      # get data from request
      request = Request.new(data)

      router.match(request)    

      #response = Response.new(file_path)
      #session.print response.build
      #session.close
      
    end
  end
end