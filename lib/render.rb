require 'erb'

class Render
  def self.render_erb(path)
    @content = ERB.new(File.read(path)).result(binding)
    template = ERB.new(File.read('views/layout.erb')).result(binding)
  end
end