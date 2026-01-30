class Request
    attr_reader :method, :resource, :version, :headers, :params

    def initialize(http_request)
        lines = http_request.split("\n")

        
        # get method, full path and version from first line
        @method, full_path, @version = lines[0].split(" ")

        # get resource from full path
        @resource, query = full_path.split("?", 2)
        
        # get params from query
        @params = {}
        if query
            query.split("&").each do |pair|
                key, value = pair.split("=", 2)
                @params[key] = value
            end
        end

        # get headers from lines after 0
        @headers = {}
        for line in lines[1..]
            key, value = line.split(": ", 2)
            @headers[key] = value
        end
    end
end

#contents = File.read('../get-fruits-with-filter.request.txt')

#test_request = Request.new(contents)