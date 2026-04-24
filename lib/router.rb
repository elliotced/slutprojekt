
class Router

    def initialize
        @routes = []
    end

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

        @routes << {method: "POST", sections: sections, block: block}
    end

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