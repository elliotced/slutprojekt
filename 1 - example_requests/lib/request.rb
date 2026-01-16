class Request
    attr_reader :method, :resource, :version, :headers, :params

    def initialize(http_request)
        lines = http_request.split("\r\n")

        
        # method + version
        mrv = lines[0].split(" ")
        @method, full_path, @version = mrv

        # resource
        @resource, query = full_path.split("?", 2)
        @params = {}
        
        # headers
        @headers = {}
            lines[1..].each do |line|
            break if line.empty?
            key, value = line.split(": ", 2)
            @headers[key] = value
        end
        
        # params
        if query
            query.split("&").each do |pair|
                k, v = pair.split("=", 2)
                @params[k] = v
            end
        end
    end
end

contents = File.read('../get-fruits-with-filter.request.txt')

test_request = Request.new(contents)

puts test_request.method
puts test_request.resource
puts test_request.version
puts test_request.headers
puts test_request.params
