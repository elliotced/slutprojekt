def Matcher
    #kolla i alla routes
    #returnea routen
    #nån annan stans, kör blocket i den returnade routen med .call
    def match(request, routes)
      for route in routes
        if request.method == route[:method] && request.resource == route[:path]
          p 'matched'
          #response = Response.new('200', request.resource)
        end
      end
    end
end