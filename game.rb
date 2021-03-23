require_relative 'interface'

class Game

  attr_accessor :money, :pc, :worker

  def initialize
    @money = 2000
    @pc = 0
    @worker = 0
  end

  def buyable(price)
    if price < @money
      @money -= price
      1
    else
      Interface.draw_message("not enough money")
      0
    end
  end

  def buy_pc
    if @pc < 10
      price = 100 + @pc * 100
      @pc += buyable(price)
      Interface.draw_pc(@pc)
    end
  end

  def hire_worker
    if @worker < 10 && @pc > @worker
      price = 100 + @worker * 100
      @worker += buyable(price)
      Interface.draw_worker(@worker)
    end
  end

end
