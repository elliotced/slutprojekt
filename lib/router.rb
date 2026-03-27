
class Router
    attr_reader :routes

    def initialize
        @routes = []
    end


    #         {path:  [{section: "users", dynamic: false}, {section: "id", dynamic: true}]}

    def get(path, &block)
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

        @routes << {method: "GET", sections: sections, block: block}
    end

    def post(path, &block)
        @routes << {method: "POST", path: "#{path}", block: block}
    end

    def match(request)
        p @routes[1]
        
        route = @routes[1]
        return route
    end
end