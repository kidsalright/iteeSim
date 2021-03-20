class Game

  attr_accessor :money

  def initialize
    @money = 999
    @pcs = 0
    @workers = []
  end

  def buyable(price)
    if price < @money
      @money -= price
    else
      exit
    end
  end

  def buy_pc
    price = 1000
    buyable(price)
  end

  def hire_worker
    price = 200
    buyable(price)
  end

end
