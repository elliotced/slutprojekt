require 'socket'
require_relative 'lib/request.rb'
require_relative 'lib/response.rb'

class HTTPServer

  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new(@port)
    puts "Listening on #{@port}"

    while session = server.accept
      data = ''
      while line = session.gets and line !~ /^\s*$/
        data += line
      end
      puts "RECEIVED REQUEST"
      puts '-' * 80
      puts data
      puts '-' * 80

      request = Request.new(data)
      path = request.resource

      paths = {
        index: "/",
        info: "/info"
      }

      html = ""
      
      if paths.value?(path)
        key = paths.key(path)
        html = File.read("views/#{key}.html")
      else
        html = File.read("views/404.html")
      end

      session.print "HTTP/1.1 200\r\n"
      session.print "Content-Type: image/png\r\n"
      session.print "\r\n"
      session.print html
      session.close
    end
  end
end

server = HTTPServer.new(4567)
server.start
