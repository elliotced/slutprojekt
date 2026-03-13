class Response

    def initialize(status, body, type)
        @status = status
        @body = body
        @type = type
    end

    def build

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