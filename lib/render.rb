require 'erb'

class Render
  def self.render_erb(show, locals = nil)
    @locals = locals
    
    @content = ERB.new(File.read(show)).result(binding)
    template = ERB.new(File.read('views/layout.erb')).result(binding)
  end
end