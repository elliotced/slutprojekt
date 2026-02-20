require 'socket'
require_relative 'lib/request.rb'
require_relative 'lib/response.rb'

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
      puts "RECEIVED REQUEST"
      puts '-' * 80
      puts data
      puts '-' * 80

      # get the path in browser
      request = Request.new(data)
      path = request.resource

      # get the correct file path 
      if path == "/"
        # index html if blank
        file_path = "views/index.html"

      elsif File.extname(path).empty?
        # no extension → assume it's an HTML page inside /views and add .html
        file_path = "views#{path}.html"

      else
        # has extension → remove first / and serve file directly
        file_path = path.delete_prefix("/")

      end
      
      # create new response object then build HTTP response string and print to the browser
      response = Response.new(file_path)
      session.print response.build
      session.close
      
    end
  end
end

# create new server object and start it with port 4567
server = HTTPServer.new(4567)
server.start
