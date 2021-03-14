require_relative 'workers'

class Hiring

  attr_reader :available

  def initialize
    @available = []
    randomizeDudes
  end

  def randomizeDudes
    8.times do |i|
      @available << Worker.new
    end
  end

end

t = Hiring.new
t.available.each { |i| puts i.rank }
