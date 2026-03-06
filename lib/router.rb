class Router

    # hash of http mime_type
    # more at: https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/MIME_types/Common_types
    mime_types = {
        ".htm" => "text/html",
        ".html" => "text/html",
        ".css" => "text/css",
        ".pdf" => "application/pdf",
        ".png" => "image/png",
        ".jpg" => "image/jpeg",
        ".jpeg" => "image/jpeg",
        ".mp3" => "audio/mpeg",
        ".mp4" => "video/mp4",
    }

    def initialize(resource)

        file_path = ""

        if resource == "/"
            # index html if blank
            file_path = "views/index.html"

        elsif File.extname(resource).empty?
            # no extension → assume it's an HTML page inside /views and add .html
            file_path = "views#{resource}.html"

        else
            # has extension → remove first / and serve file directly
            file_path = resource.delete_prefix("/")
        end

        # if file exists 
        if File.exist?(file_path) && !File.directory?(file_path)
            status = "200 OK"
            body = File.binread(file_path)
            mime_type = mime_types[file_path.extname]
        # if file does not exist
        else
            status = "404 Not Found"
            body = File.read("views/404.html")
            mime_type = "text/html"
        end
    end
end