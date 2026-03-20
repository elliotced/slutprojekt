require_relative 'lib/router.rb'
require_relative 'lib/render.rb'
require_relative 'lib/tcp_server.rb'

router = Router.new

router.get('/') do
    @content = ERB.new(File.read('views/index.erb')).result(binding)
    template = ERB.new(File.read('views/layout.erb')).result(binding)
end

router.get('/info') do
    @content = ERB.new(File.read('views/info.erb')).result(binding)
    template = ERB.new(File.read('views/layout.erb')).result(binding)
end

router.get('/fruit/:id') do | id |
    @fruit = id

    @content = ERB.new(File.read('views/fruit/show.erb')).result(binding)
    template = ERB.new(File.read('views/layout.erb')).result(binding)

    #Render.render_erb('views/fruit/show.erb')
end


# create server and start it on port 4567
server = HTTPServer.new(router, 4567)
server.start
