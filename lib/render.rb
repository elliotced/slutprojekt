require 'erb'

class Render
  # Creates an erb doc
  # 
  # @param show [String] html document
  # @param locals [Hash] hash of all variables to be included
  # @return [void]
  def self.render_erb(show, locals = nil)
    @locals = locals
    
    @content = ERB.new(File.read(show)).result(binding)
    template = ERB.new(File.read('views/layout.erb')).result(binding)
  end
end