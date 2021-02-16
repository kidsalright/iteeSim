require_relative 'control'
require_relative 'arts'

class IO

  def initialize
    @main = Control.new
    @arts = Arts.new
  end

end
