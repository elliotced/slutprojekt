require 'socket'
require 'json'
require_relative 'request.rb'
require_relative 'response.rb'

# The server class. Handles communication with the user and different classes within the server
#
# @example Starting the server on the port 4567
#   server = HTTPServer.new(router, 4567)
#   server.start
class HTTPServer

  def initialize(router, port)
    # give port var its value for use when starting server
    @port = port
    @router = router
    @sessions = {"GUUGPPRI" => {darkmode: true},
                 "SMWCQQMJ" => {darkmode: false}
                }
    @sessionid = ""
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

      # get sessionid from cookie data
      cookie = request.headers["Cookie"]
      if cookie
        cookievars = cookie.split(";")
        for var in cookievars
          name, value = var.split("=", 2)
          if name == "sessionid"
            @sessionid = value
          end
        end
      end

      # set sessionid if none exists in cookies
      if @sessionid == ""
        @sessionid = (0...8).map { (65 + rand(26)).chr }.join
      end

      # see if sessionid matches with stored
      if @sessions.include? @sessionid
        p "session match"
      else
        @sessions[@sessionid] = {darkmode: true}
      end
      
      # match request to route
      route = @router.match(request)

      # create response
      response = Response.new(request, route, @sessionid)

      # build and print response
      session.print response.build
      session.close
      
    end
  end
end