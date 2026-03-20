
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
        # static routes
        route = routes.find {|route| route[:method] == request.method && route[:path] == request.resource}
        if route
            return [route]  
        end

        # dynamic routes
        split = request.resource.delete_prefix("/").split("/")
        static = split[0]
        dynamic = split[1]
        
        route = routes.find {|route| route[:method] == request.method &&
            route[:path].delete_prefix("/").split("/")[0] == static}

        if route
            return [route, dynamic]
        else
            # no route found
            return nil
        end
    end
end