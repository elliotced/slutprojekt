class Response
    # matrix of all file name extenstions and their HTTP type
    CONTENT_TYPES = {
    ".html" => "text/html",
    ".css"  => "text/css",
    ".js"   => "application/javascript",
    ".png"  => "image/png",
    ".jpg"  => "image/jpeg",
    ".jpeg" => "image/jpeg",
    ".gif"  => "image/gif"
    }

  def initialize(path)
    # give path var its value for use when building HTTP response
    @path = path
  end

  # build the HTTP response string
  def build
    # if path exists in server set correct information
    if File.exist?(@path) && !File.directory?(@path)
      status = "200 OK"
      body = File.binread(@path)
      content_type = content_type_for(@path)
    
    # if path does not exist load 404 doc
    else
      status = "404 Not Found"
      body = File.read("views/404.html")
      content_type = "text/html"

    end

    # insert the correct information into the output
    headers = []
    headers << "HTTP/1.1 #{status}"
    headers << "Content-Type: #{content_type}"
    headers << "Content-Length: #{body.bytesize}"
    headers << "\r\n"

    headers.join("\r\n") + body
  end

  private

  def content_type_for(path)
    ext = File.extname(path)
    CONTENT_TYPES.fetch(ext, "application/octet-stream")
  end
end