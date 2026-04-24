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
    puts "http://localhost:#{@port}\n\n"

    # wait until a user connects server
    while session = server.accept
      # create data
      data = ''
      while line = session.gets and line !~ /^\s*$/
        data += line
      end

      # create request from data
      request = Request.new(data)
      # match request to route
      route = @router.match(request)

      # create response
      response = Response.new(request, route)

      # build and print response
      session.print response.build
      session.close
      
    end
  end
end