
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
      return @routes.find {|route| route[:method] == request.method && route[:path] == request.resource}
    end
end