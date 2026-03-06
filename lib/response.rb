class Response

    def initialize(status, headers, body)
        @status = status
        @headers = headers
        @body = body
    end

    def build

        output = []
        # status line
        output = "HTTP/1.1 #{@status}\r\n"
        # headers
        for header in @headers
            output << header
        end
        # empty line
        output << "\r\n"
        # body
        output << @body

        return output
    end
end