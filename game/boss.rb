require_relative 'workers'

class Boss

  attr_reader :balance, :office, :workers, :computers

  def initialize
    @balance = 10000
    @office = 0
    @computers = 0
    @workers = [Worker.new]
  end

end
