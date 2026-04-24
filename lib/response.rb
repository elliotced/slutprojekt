require_relative 'mime.rb'
require_relative 'render.rb'
require_relative 'redirect.rb'

class Response

    def initialize(request, route)
        @request = request
        @route = route
    end

    def build

        @status = ""
        @body = ""
        @type = ""

        # get correct response arguments from route
        if @route
            # routes
            @status = "200 OK"
            @body = @route[:block].call(@route[:params])
            # redirects
            if @body.class == Redirect
                output = []
                # status line
                output = "HTTP/1.1 303 See Other\r\n"
                # headers
                output << "Location: #{@body.path}\r\n"
                # empty line
                output << "\r\n"

                return output
            end
            @type = "text/html"
        elsif File.exist?(@request.resource.delete_prefix("/"))
            # static files
            @status = "200 OK"
            path = @request.resource.delete_prefix("/")
            @body = File.binread(path)
            @type = Mime.get_type(File.extname(path))
        else
            # 404 not found
            @status = "404 Not Found"
            @body = Render.render_erb("views/404.erb")
            @type = "text/html"
        end

        output = []
        # status line
        output = "HTTP/1.1 #{@status}\r\n"
        # headers
        output << "Content-Type: #{@type}\r\n"
        output << "Content-Length: #{@body.bytesize}\r\n"
        output << "Connection: close\r\n"
        # empty line
        output << "\r\n"
        # body
        output << @body

        return output
    end
end