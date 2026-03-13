class Mime
    #https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/MIME_types/Common_types
    TYPES = {
    ".html" => "text/html",
    ".css"  => "text/css",
    ".js"   => "application/javascript",
    ".png"  => "image/png",
    ".jpg"  => "image/jpeg",
    ".jpeg" => "image/jpeg",
    ".gif"  => "image/gif"
    }


    def self.get_type(extension)
      TYPES.fetch(extension)
    end
end