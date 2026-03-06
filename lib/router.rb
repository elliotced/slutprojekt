
class Router
    attr_reader :routes

    def initialize
        @routes = []
    end

    def get(path, &block)
        @routes << {method: "GET", path: "#{path}", block: block}
    end

    def post(path, &block)
        @routes << {method: "POST", path: "#{path}", block: block}
    end

    #kolla i alla routes
    #returnea routen
    #nån annan stans, kör blocket i den returnade routen med .call
    def match(request)
      for route in @routes
        if request.method == route[:method] && request.resource == route[:path]
          p 'matched'
          response = Response.new('200', request.resource)
        end
      end
    end
end