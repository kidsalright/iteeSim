require_relative 'orders'

class Market

  attr_reader :available

  def initialize
    @available = []
    createOrders
  end

  def createOrders
    (1..3).each do |type|
      counter = rand(2..5)
      while counter != 0
        if type == 1
          @available << SimpleOrders.new
        end
        if type == 2
          @available << MiddleOrders.new
        end
        if type == 3
          @available << HardOrders.new
        end
        counter -= 1
      end
    end
  end

end
