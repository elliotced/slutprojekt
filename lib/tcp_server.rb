require 'socket'
require_relative 'request.rb'
require_relative 'response.rb'
require_relative 'mime.rb'

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

    # wait until a user connects to server
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
      status = ""
      body = ""
      type = ""

      # get correct response arguments from route
      if route
        # views/ html docs
        status = "200 OK"
        body = route[:block].call
        type = "text/html"
      elsif File.exist?(request.resource.delete_prefix("/"))
        # public/ files
        status = "200 OK"
        path = request.resource.delete_prefix("/")
        body = File.binread(path)
        type = Mime.get_type(File.extname(path))
      else
        # 404 not found
        status = "404 Not Found"
        body = File.read("views/404.html")
        type = "text/html"
      end

      # create response
      response = Response.new(status, body, type)

      # build and print response
      session.print response.build
      session.close
      
    end
  end
end