require_relative 'lib/router.rb'
require_relative 'lib/tcp_server.rb'

router = Router.new

router.get('/') do
    File.read('index.html')
end

router.get('/info') do
    File.read('info.html')
end

router.get('/add/:num1/:num2') do |num1, num2| 
    return (num1+num2).to_s
end


# create server and start it on port 4567
server = HTTPServer.new(router, 4567)
server.start
