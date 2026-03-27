require_relative 'lib/router.rb'
require_relative 'lib/render.rb'
require_relative 'lib/tcp_server.rb'

router = Router.new

router.get('/') do
    show = 'views/index.erb'

    Render.render_erb(show)
end

router.get('/info') do
    show = 'views/info.erb'

    Render.render_erb(show)
end

router.get('/fruit/:id') do | id |
    show = 'views/fruit/show.erb'
    locals = {
    "id" => id
    }

    Render.render_erb(show, locals)
end


# create server and start it on port 4567
server = HTTPServer.new(router, 4567)
server.start
