# Handles route registration and route matching for HTTP requests
#
# @example Creating routes
#   router = Router.new
#
#   router.get('/info') do
#       show = 'views/info.erb'
#       Render.render_erb(show)
#   end
#
#   router.post('/redirect') do
#       Redirect.new('/info')
#   end
class Router

    def initialize
        @routes = []
    end

    # Sends information to create a GET route with create_route
    # 
    # @param path [String] path in plain text
    # @param block [String] content of the route
    # @return [void]
    def get(path, &block)
        create_route("GET", path, block)
    end

    # Sends information to create a POST route with create_route
    # 
    # @param path [String] path in plain text
    # @param block [String] content of the route
    # @return [void]
    def post(path, &block)
        create_route("POST", path, block)
    end

    # Creates a new route and adds it to the list of routes in server
    # 
    # @param method [String] method of the route
    # @param path [String] path in plain text
    # @param block [Block] content of the route
    # @return [void]
    def create_route(method, path, block)
        parts = path.delete_prefix("/").split("/")
        # solve index part
        if parts == []
            parts = [""]
        end
        
        sections = []
        # convert part to dynamic or static section
        for part in parts
            dynamic = false
            if part.start_with?(":")
                dynamic = true
            end
            sections << {section: "/#{part}", dynamic: dynamic}   
        end

        @routes << {method: method, sections: sections, block: block}
    end

    # Matches a requests path with a route stores in @routes
    # 
    # @param request [Object] object containing attributes of the browser request
    # @return [Hash, nil] the matching route, or nil if not found
    def match(request)
        parts = (request.resource).delete_prefix("/").split("/")
        # solve index part
        if parts == []
            parts = [""]
        end

        for route in @routes
            if parts.length == route[:sections].length
                matched = true
                params = []
                i = 0
                while i < parts.length
                    if (route[:sections][i])[:dynamic] == false
                        #static parts
                        if parts[i] != (route[:sections][i])[:section].delete_prefix("/")
                            matched = false
                            break
                        end
                    else
                        #dynamic parts
                        params << parts[i]
                    end
                    i += 1
                end

                if matched
                    route[:params] = params
                    # fix if only one param
                    if route[:params].size < 2
                        route[:params] = (route[:params])[0]
                    end
                    return route
                end
            end
        end

        return nil
    end
end